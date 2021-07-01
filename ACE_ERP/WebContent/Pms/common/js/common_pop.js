/***********************************************************************
 * 	각 업무시스템에서 공용으로 사용하는 스크립트 메서드
 *  정리할 필요가 있습니다.
 *  지나친 스크립트는 사용자 부분의 부하를 증가시킴...
************************************************************************/

var arrParam;


//현장 팝- 기본(sid, 현장명)
	function fnCtSitePop(dir) {

	    var strURL = dir+"/Pms/help/ct010h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//현장 팝- 기본(sid, 현장명, 발주처, 계약차수, 변경차수, 계약금액, 공급가액, 부가세 )
	function fnCtSitePop1(dir) {
	    var strURL = dir+"/Pms/help/ct012h.jsp";
	    var strPos = "dialogWidth:720px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}


//공종 팝
	function fnCtKindPop(dir) {
	    var strURL = dir+"/Pms/help/ct011h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
//품목 팝
	function fnCtKindPop2(dir) {
	    var strURL = dir+"/Pms/help/ct031h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}

//업체 팝
	function fnCtCoopPop(dir) {
		var strURL = dir+"/Pms/help/sy030h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}
	//거래처 팝
	function fnCtCoopPop1(dir) {
		var strURL = dir+"/Pms/help/sy030h_01.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
	}
	
	//품목 팝
	function fnItemPop(dir) {
		var strURL = dir+"/Pms/help/sy030h_02.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
	}

	//규격 팝
	function fnItemSizePop(dir) {
		var strURL = dir+"/Pms/help/sy030h_03.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
	}

    //발주처 팝 
	function fnCtOrdererPop(dir) {
		var strURL = dir+"/Pms/help/sy040h.jsp";
		var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		var return_value = showModalDialog(strURL,arrParam,strPos);	
		
		return return_value;
			
	}

	// 달력 팝업 (기존 달력소스 이용.. 다른 것들과 다르게 파라미터를 미리 배열로 던져줌.
	function fnCalPopup(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//년,월,일, 년월일 순임
            if(arrResult[3] < v_fr_rqst_date.text){
            	alert("소요일은 청구일자 이후여야 합니다.\n\n다시 선택해 주시기 바랍니다.");
            }else{
		   		ds_tender.namevalue(ds_tender.rowposition, "DATE_USE")  = arrResult[3];
		   	}
        }
    }

	// 달력 팝업 (기존 달력소스 이용.. 다른 것들과 다르게 파라미터를 미리 배열로 던져줌.
	function fnCalPopup2(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//년,월,일, 년월일 순임
           		ds_detail.namevalue(ds_detail.rowposition, "DATE_CON")  = arrResult[3];
		}
    }
    
    // 달력 팝업 (자재구매_검수정산 메뉴에서 검수일자)
	function fnCalPopup3(dirPath,servletPath){
		//alert("3");
        var arrResult   = new Array();
        arrResult = fnCalPop(dirPath);
        if (arrResult != null) {
            //alert(arrResult[3]);//년,월,일, 년월일 순임
           		ds_detail.namevalue(ds_detail.rowposition, "DATE_CGC")  = arrResult[3];
        }
    }
    //자재구매_현장 팝- 기본(sid, 현장명)
	function fnPuSitePop(dir) {

	    var strURL = dir+"/Pms/help/pu010h_01.jsp";
	    var strPos = "dialogWidth:595px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
    //자재구매_현장 팝- 기본(sid, 현장명)
	function fnPuSitePop1(dir) {

	    var strURL = dir+"/Pms/help/pu010h_01.jsp";
	    var strPos = "dialogWidth:595px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	//-------------------------------------------------------------------------------------------------->
	
	//회계 원가코드 - 기본
	function fnSiCostPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_01.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//회계 계정과목 - 기본
	function fnSiAccPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_02.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//법인카드 
	function fnSiCardPop1(dir) {

	    var strURL = dir+"/Pms/help/si010h_04.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//개인명 법인카드 
	function fnSiCardPop2(dir) {

	    var strURL = dir+"/Pms/help/si010h_03.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//자산명코드 
	function fnSiAstnbrPop(dir,vcostcd) {
	    
	    var arr	= new Array(); 
        arr[0]=vcostcd;
	    var strURL = dir+"/Pms/help/si010h_05.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arr,strPos); 
	    
	    return return_value;
	}
	
	//작성자 
	function fnSiEmpPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_06.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//거래처  
	function fnSiCustPop(dir) {

	    var strURL = dir+"/Pms/help/si010h_07.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
	    
	    return return_value;
	}
	
	
	//출납공정   
	function fnSiBidSitePop(dir, vcostcd) {
	
	    var arr	= new Array(); 
        arr[0]=vcostcd;

	    var strURL = dir+"/Pms/help/si010h_09.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arr,strPos); 
	    
	    return return_value;
	}

	
// 여기까지 새로 만드는 것들 ------------------------------------------------------------------------------------>



	

/**
 * 로딩바 표시 / 감추기 - 심동현 : 2008-02-19
**/
function fnShowLoading(intWidth, intHeight)
{
	document.all.loadingBar.style.left   = (document.body.clientWidth - intWidth)/2;
	document.all.loadingBar.style.top    = (document.body.clientHeight - intHeight)/2;
	document.all.loadingBar.style.width  = intWidth;
	document.all.loadingBar.style.height = intHeight;
	document.all.loadingBar.style.display="";
}

function fnHideLoading()
{
	document.all.loadingBar.style.display="none";
} 	




// 달력 띄우기 - 심동현 : 2010-02-19		이건 html 파일을 여는게 더 좋을 수도 있네요..
function fnCalPop(dir){
	//alert("1");
    var strURL = dir+ "/Sales/common/include/com_calender.jsp";
    var strPos = "dialogWidth:180px;dialogHeight:230px;status:no;scroll:no;resizable:no";
    var return_value = showModalDialog(strURL,arrParam,strPos); 
    //alert(return_value);
    return return_value;
}    

/******************************************************************************************
	2013.12.27
	Descrition : IE 패치후 발생하는 컴퍼넌트 문제를 위한것
******************************************************************************************/
function __WS__(id){
document.write(id.innerHTML);
id.id = "";
}
