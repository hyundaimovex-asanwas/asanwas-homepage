/*****************************************************
* @source      : fileupload.js
* @description : 파일 업로드에 관련된 공통 스크립트  모음
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/07/22      이동훈                  ERP 이사
*****************************************************/

/**
 * 이미지 파일만 업로드 가능하게
 * $param key - 파일에 해당하는 유일키 (프로그램명+해당테이블 모든 키+..)
 */
function fnc_AddFileImg(key) {
	
	fnc_AddFile(key, true);
	
}

/**
 * 새로운 파일 추가
 * $param key - 파일에 해당하는 유일키 (프로그램명+해당테이블 모든 키+..)
 * $param isImg - 이미지 파일만 업로드 할것인지 여부 결정 (Boolean)
 */
function fnc_AddFile(key, isImg) {
	
	var dsFILE = document.getElementById("dsFILE");
	var foFILE = document.getElementById("foFILE");
	
	var fileUrl;
	var fileName;
	

	if (dsFILE.CountColumn == 0)
		dsFILE.setDataHeader("KEY:STRING, SEQ_NO:INT, FILE_NAME:STRING, FILE_URL:STRING, UPLOAD_URL:URL");
	
	dsFILE.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */
	
	dsFILE.addrow();

	foFILE.Open();
	
	//확인을 클릭했는지 여부 검증
	if(foFILE.SelectState != true) {
		
		dsFILE.deleterow(dsFILE.RowPosition);
		
	    return false;       
	    
    }
	
	fileUrl = foFILE.value;
	
	fileName = fileUrl.substring(fileUrl.lastIndexOf("\\") + 1, fileUrl.length);
	
	//alert(isImg);
	//alert(fileUrl);
	//이미지만 등록가능하게
	if(isImg != undefined && isImg == true) {
		
            var obj = fileName.split(".");
            
            var ext;

            if(obj.length != 2) {
            	
                alert("파일 형식이 잘못 되었습니다. 확인해 주세요.");
                
                return false;
                
            } else {
            	
                ext = obj[1].toLowerCase();
                
            }

            if(ext != "gif" && ext != "jpg" && ext != "bmp" && ext != "png" && ext != "pdf") {
            	
                alert("이미지 파일만 업로드가 가능합니다.");
                
                dsFILE.deleterow(dsFILE.RowPosition);
                
                return false;
                
            }
            
	}

	
	dsFILE.NameValue(dsFILE.RowPosition, "KEY") = key;
	dsFILE.NameValue(dsFILE.RowPosition, "FILE_NAME")	= fileName;	
	dsFILE.NameValue(dsFILE.RowPosition, "FILE_URL")	= fileUrl;
	dsFILE.NameValue(dsFILE.RowPosition, "UPLOAD_URL")	= fileUrl;

	//새로추가한 파일을 DB에 저장
	fnc_InsFile();
	
	return true;
	
}

/**
 * 파일 항목 리스트를 가지고 온다.
 * @param key - file key
 */
function fnc_GetFileList(key) {
	
	var dsFILE = document.getElementById("dsFILE");
	
	dsFILE.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=SHR&KEY="+key;
	
	dsFILE.Reset();	
}

/**
 * 파일 항목 리스트를 가지고 온다.
 * @param key - file key
 * @param seq_no - file seq_no 
 */
function fnc_GetFile(key, seq_no) {
	
	var dsFILE = document.getElementById("dsFILE");

	dsFILE.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=SHR&KEY="+key+"&SEQ_NO="+seq_no;
	
	dsFILE.Reset();	
}

/**
 * 파일 항목 리스트를 등록한다.
 */
function fnc_InsFile() {

	var trFILE = document.getElementById("trFILE");
	
	trFILE.KeyValue	= "file(I:FILE=dsFILE)";
	
	trFILE.action 	= "../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=INS";

	trFILE.post();	
}

/**
 * 파일 항목을 삭제한다.
 */
function fnc_DelFile() {
	
	var trFILE = document.getElementById("trFILE");

	trFILE.KeyValue	= "file(I:FILE=dsFILE)";
	
	trFILE.action 	= "../../../servlet/GauceChannelSVL?cmd=Ehr.common.file.cmd.FILECMD&S_MODE=DEL";
	
	trFILE.post();	
	
}

