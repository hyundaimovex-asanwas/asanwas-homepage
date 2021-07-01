	<!--*************************************************************************
	* @source      : pirg010.jsp												*
	* @description : 사진화일전송 PAGE 											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/09            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    Configuration conf = Configuration.getInstance();

    String DIR_PATH = conf.get("framework.file.upload.pds");
%>
<html>
<head>
	<title>사진화일전송(pirg010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFTFT';
		var img = null;  // 사진 보여주기

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
       		trFILE_SEARCH.KeyValue = "tr01(O:dsFILE_SEARCH_SV=dsFILE_SEARCH_SV, O:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
			trFILE_SEARCH.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=SHR";
			trFILE_SEARCH.post();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
            if(!confirm("선택하신 파일 모두를 올리시겠습니까?")) {
                return false;
            }
            dsFILE_SEARCH_TP.UseChangeInfo = "false";

			trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
			trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=SAV";
			trFILE_UPLOAD.post();
        }

        /**
         * 선택한 사진 다운
         */
        function fnc_Down() {
            var vFILE_NAME  = dsFILE_SEARCH_SV.NameValue(dsFILE_SEARCH_SV.RowPosition,"FILE_NAME");
            var vFILE_URL   = dsFILE_SEARCH_SV.NameValue(dsFILE_SEARCH_SV.RowPosition,"FILE_URL");

            cfDownload(vFILE_NAME, vFILE_URL);
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
        	document.getElementById("resultMessage").innerText = ' ';
        	dsFILE_UPLOAD.ClearData();
        	dsFILE_SEARCH_SV.ClearData();
        	dsFILE_SEARCH_TP.ClearData();

            img.setImage("/images/common/none.jpg");
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsFILE_UPLOAD.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	img = new Image(document.form1.viewImage);

			cfStyleGrid(form1.grdFILE_SEARCH_TP,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdFILE_SEARCH_SV,0,"false","false");      // Grid Style 적용

			// 파일 첨부용 데이터셋의 헤더 정보 설정.
	        dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");

			fnc_SearchList();
        }


		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/**
		 * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
		 * - usage : var obj = new Image(이미지테그의ID);
		 *               obj.setImage("서버의 이미지파일의 위치및 파일명");
		 **/
		function Image(imgTag) {
			var imgTag = imgTag;
			var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
			var imgUrl = "";
			this.setImage = function(img) {
				imgUrl = img;
				imgTag.src = action + "&IMAGE=" +imgUrl;
			}
		}


        /**
         * 새로운 파일을 추가 한다.
         */
		function fnc_AddFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            oFile_url   = fcFILE_UPLOAD.Value;
            oFile_name  = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            
            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;   

            var tmp     = fcFILE_UPLOAD.Value.split(".");
            var length  = tmp.length;
            var ext     = tmp[length-1].toLowerCase();

            if(!(length > 0
                    && (   ext == "jpg"
                        || ext == "gif"
                        || ext == "jpeg"
                        || ext == "bmp"
                        || ext == "png"))) {
                alert("이미지 형식의 파일만 업로드 가능합니다.");
                return;
            }
 
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_NAME") = oFile_name;
            
            
            
            //파일 첨부와 동시에 서버에 업로드
            fnc_FileUpload();
		}
        
        /**
         * 실제로 파일을 등록시킨다.
         */
        function fnc_FileUpload() {
            dsFILE_UPLOAD.UseChangeInfo = "false";

            
            //prompt(this,dsFILE_UPLOAD.text);            
            
            trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD)";
            trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=ULD";
            
            trFILE_UPLOAD.post();
        }

		/**
         * 첨부된 파일을 삭제시킨다.
         */
		function fnc_FileDelete(type) {
            var oDATA_SET;
            
            //사용할 DATASET 결정
            if(type == "temp") {
                oDATA_SET = dsFILE_SEARCH_TP;
            } else {
                oDATA_SET = dsFILE_SEARCH_SV;
            }
        
			if (oDATA_SET.CountRow < 1) {
                alert("삭제 할 파일이 없습니다!");
                return;
            }else{
                var FILE_NAME = oDATA_SET.nameValue(oDATA_SET.RowPosition, "FILE_NAME");
            	var tmpMSG = "아래 행을 삭제하시겠습니까?\n파일명     = "+FILE_NAME+"\n";

	            if( confirm(tmpMSG) ){
					oDATA_SET.DeleteRow(oDATA_SET.RowPosition);

					// 파라미터 추가
					trFILE_UPLOAD.KeyValue = "tr02(I:dsFILE_SEARCH_SV=dsFILE_SEARCH_SV, I:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
					trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=DEL&FILE_NAME="+FILE_NAME+"&TYPE="+type;
					trFILE_UPLOAD.post();

					img.setImage("/images/common/none.jpg");
				}
			}
		}


    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ (FILE_SEARCH_CL)			   			   |
    | 3. 사용되는 Table List								   |
    +------------------------------------------------------>
	<Object ID="dsFILE_SEARCH_SV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>
    
	<Object ID="dsFILE_SEARCH_TP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"              value='첨부파일'>
        <param name="Enable"            value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			   |
    | 2. 이름은 tr_ + 주요 테이블명(FILE_SEARCH_CL)		   |
    | 3. 사용되는 Table List(FILE_SEARCH_CL)			   |
    +------------------------------------------------------>
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>
    
    <Object ID ="trFILE_SEARCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

 	<!-- 가우스 파일 오브젝트 -->
	<object id=tb_InputFile classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
		<param name="Text"			value='FileOpen'>
		<param name="OpenFileName"	value='내 문서'>
		<param name="Enable"		value="true">
	</object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsFILE_UPLOAD Event="OnLoadCompleted(iCount)">

    </Script>

	<Script For=dsFILE_SEARCH_SV Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsFILE_SEARCH_CL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsFILE_SEARCH_CL Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trFILE_UPLOAD event="OnSuccess()">
        dsFILE_SEARCH_TP.UseChangeInfo = "true";
    
		fnc_Clear();
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>
    
	<script for=trFILE_SEARCH event="OnFail()">
        alert(trFILE_SEARCH.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Grid 클릭시 이미지 미리보기 - server							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdFILE_SEARCH_SV event=OnClick(row,colid)>
	
        //server
        //alert(dsFILE_SEARCH_SV.NameValue(row, "FILE_URL"));
        
		img.setImage(dsFILE_SEARCH_SV.NameValue(row,"FILE_URL"));

        fnc_ShowElement("btnDOWN");
        fnc_HiddenElement("btnSAVE");
        
	</script>

	<!-----------------------------------------------------+
    | Grid 클릭시 이미지 미리보기 - temp							|
    +------------------------------------------------------>
	<script language="javascript"  for=grdFILE_SEARCH_TP event=OnClick(row,colid)>
	
	    //temp
	    //alert(dsFILE_SEARCH_TP.NameValue(row, "FILE_URL"));
	    
		img.setImage(dsFILE_SEARCH_TP.NameValue(row, "FILE_URL"));

        fnc_ShowElement("btnSAVE");
        fnc_HiddenElement("btnDOWN");
        
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사진화일전송</td>
					<td align="right" class="navigator">HOME/인사관리/<font color="#000000">사진화일전송</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<b>Temp</b><br>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_AddFile()"></a>
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete('temp')"></a>
					</td>
					<td>&nbsp;</td>
					<td>
						<b>Server</b><br>
						<input id="txtLOC_SV" size="33" class="input_ReadOnly" readonly value="<%=DIR_PATH %>">
<!--
    서버쪽 이미지 삭제 버튼 차후에 사용
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete('server')"></a>
-->
					</td>
				</tr>
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id=grdFILE_SEARCH_TP classid=CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="width:300px;height:390px;">
    					<param name="DataID"		value='dsFILE_SEARCH_TP'>
    					<param name="ColSelect"		value='true'>
    					<param name="Format"		value='
    						<C> id="{curow}"		width=30	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
    						<C> id="FILE_NAME"		width=250	name="파일명"		align=left		Edit=none	 LeftMargin="10"</C>
                        '>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" width="200px" height="100px">
						<table style="border:1px solid #000000;width:150px;height:200px"  cellspacing="0" cellpadding="0">
						<tr>
						<td>
							<img id="viewImage" src="init" border="0" onerror="this.src='/images/common/none.jpg';" style="width:150px;height:200px;">
						</td>
						</tr>
						</table>
						<br>
						<br>
						<br>
						<input id="btnSAVE" name="btnSAVE" type="button" value="올리기" style="width:100px" onclick="fnc_Save()">
						<input id="btnDOWN" name="btnDOWN" type="button" value="내려받기" style="width:100px" onclick="fnc_Down()" style="display:none;">
					</td>
					<td>
					<comment id="__NSID__">
					<object id="grdFILE_SEARCH_SV" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:390px;">
						<param name="DataID" value="dsFILE_SEARCH_SV">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{curow}"		width=30	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="FILE_NAME"		width=250	name="파일명"		align=left		Edit=none	 LeftMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>
