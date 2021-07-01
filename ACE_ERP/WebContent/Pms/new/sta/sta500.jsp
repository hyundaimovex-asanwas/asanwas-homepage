<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 매출등록 - 계산서
 * 프로그램ID 	 : PMS/Sta
 * J  S  P		 : Sta500.jsp
 * 서 블 릿		 : Sta500
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-21
 * 기능정의		 : 매출등록 - 계산서
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/


	var gs_userid = gusrid;
	var gs_fdcode;
	
	var gstrempno="";
	var gstrdeptcd="";
	var gstrGubun ="";
	var gstrAuthgr="";
	var gstrRowpos="";




	var v_default_row = 1;
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
	
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		
		fnInit();
		
	}
	
	<%//초기작업 %>
	function fnInit() {
		
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";		
		
		
    	//지점코드
    	ds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
    	ds_fdcode.Reset();


    	//부가세종류[매입]
    	ds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
    	ds_staxknd.Reset();

    	//alert(ds_fdcode.countrow);
    	
		//alert("18");
        

	
		//fnSelect();
	    
	}

	
	

	
	
    <%//메인 조회  %>
    function fnSelect() {
    	
		    v_job="S";

	        var fr_date = v_fr_date.Text.trim();
	        var to_date = v_to_date.Text.trim();

	        if(fr_date.length!=8) {
	            alert("계산서일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("계산서일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}

	                  
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									                + ",v_frdt=" + fr_date
									                + ",v_todt=" + to_date;    
									                
	                  								//+ ",v_journal="  + v_journal.value	                  								
													//+ ",v_journal="  + v_journal.value;
	                  								
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta100",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    	
	

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

        gstrAuthgr="A"; 

		var str1 = gclx_staxiodiv.BindColVal;	 //매입매출구분
		var str2 = gclx_cocode.BindColVal;		 //사업소
		var str3 = gcem_staxdatfr.text;			 //계산서기간 from
		var str4 = gcem_staxdatto.text;			 //계산서기간 to
		var str5 = gcem_vendcd.text;			 //거래처코드
		var str6 = "";		                     //귀속구분
		var str7 = "";	                      	 //부가세종류
		var str8 = "";                      	 //발행여부
		var str9 = gclx_fsstat.BindColVal;		 //전표상태
		var str10 = gcem_vendnm.text;			 //거래처명
		var str11 = gclx_fdcode.BindColVal;		 //지점코드
		var str12 = gs_userid;	                 //로그인
		var str17 = "";                          //수정코드
		var gs_chk="";
		var str18 = gclx_gubun.BindColVal;       //전자발행구분
		var str19 = gcem_empno.text;             //작성자
		var str21 = gclx_ebillgb.bindcolval;     //ebill구분
		

		if (str1 =="1") {       //매입
			str1 = "A";
			str7 = gclx_staxknd.BindColVal;
		}else if (str1 =="2") { //매출
			str1 = "B";
			str7 = gclx_staxknd_2.BindColVal;		
  	    }
		
		if(gstrAuthgr=="A"){ //부가세 관리자
			str13 = "1";	
		}else{
            str13 = "2";            //일반사용자	
		}


    	if(str1 =="A"){         //매입
			//세금계산서 ( 과세 +불공+영세 ) 
			if(str7=="9"){
				str7= "1','2','4";
			}else if (str7=="6"){
				str7= "1','2','4','7','8";
			}
    	}else if(str1 =="B"){  //매출
			if(str7=="9"){  //세금계산서 (과세+영세)
				str7= "1','2";
			}
		}

		//세금계산서+기타  ( 과세 +불공+영세 + 신용카드 + 현금영수증  ) 
    
    	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+"?v_str1="+str1+"&v_str2="+str2
											+"&v_str3="+str3+"&v_str4="+str4
											+"&v_str5="+str5+"&v_str6="+str6
											+"&v_str7="+str7+"&v_str8="+str8
											+"&v_str9="+str9+"&v_str10="+str10
											+"&v_str11="+str11+"&v_str12="+gs_chk
											+"&v_str13="+str12+"&v_str14="+str13
											+"&v_str15="+gstrempno+"&v_str16="+gstrdeptcd
											+"&v_str17="+str17+"&v_str18="+str18
											+"&v_str19="+str19+"&v_str21="+str21;
											
		//prompt('',gcds_data.DataID);
		gcds_data.Reset();
}


	/******************************************************************************
		Description : 찾기 - 거래처코드
	******************************************************************************/
	function ln_Popup(){
	    var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
	   //2013.01.15 jys 
	   //arrVAT[0]="VAT";
		//arrVAT[0]="";
	
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
		}
	}





    <%//직원 팝- 검색조건 처리자 : 관리자만 가능하게%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }

    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }





	/******************************************************************************
		Description : 찾기 - 작성자 
	******************************************************************************/
	function ln_Popup_Empno(){
	
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	 
		strURL = "./empno_popup3.jsp";
		strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
	 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	        gcem_empno.text    = arrParam[0];
	    }else{
	        gcem_empno.text    = "";
	    }
	}

	
	
	
	
	/***********************************************************************************************
		Description : 전표조회
		parameter   : 
	**********************************************************************************************/
	function ln_Slipno(){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") != "") {	
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL="";	
			var strPos="";
	
			arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
			arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FSDAT");
			arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"FSNBR");
	
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
		}else if (gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") == "") {
			alert("발행 된 전표가 없습니다.");
		}
	
	}

	
	

	/******************************************************************************
		Description : 세금계산서 보기
		parameter   :            
	******************************************************************************/
	function ln_Bill_View(){
	
	   if(!ln_Bill_Chk()) return;
	   
	
		if (gcds_data.IsUpdated){
			gs_sm_call_status="V"; // 계산서보기 tag
			ln_Batch_id();
		}
	}

	
	
	
	
	/******************************************************************************
		Description : 세금계산서 보기 체크 
		parameter   :            
	******************************************************************************/
	function ln_Bill_Chk(){
		var view_chk ="";
	
	   //매출 일경우만 가능
	   //매출 중 수신승인 또는 수신 미승인만 가능 
	   for(var i=1;i<=gcds_data.countrow;i++){
		   if (gcds_data.namevalue(i,"CHK")=="T"){
		   		if(gcds_data.namevalue(i,"SUPBUY_TYPE")=="AR" ){
		   			if(gcds_data.namevalue(i,"DTI_STATUS")=="I"||gcds_data.namevalue(i,"DTI_STATUS")=="C" ){
		   				
		   			}else{
		   			
		   			   alert( i +" 행은 세금계산서 보기가 되지 않습니다. 확인바랍니다. 1");
					   return false;
		   			}
		   		}else{
		   		    alert( " 매출세금계산서만 가능합니다. "+ i +" 행은 세금계산서 보기가 되지 않습니다. 확인바랍니다. 2");
		   			return false;
		   		}
		   }
	   }
	   
	   return true;
	}

	
	
	
	/******************************************************************************
		Description : Interface_Batch_id 생성 및 사번으로 id, pw 찾기
		parameter   :            
	******************************************************************************/
	function ln_Batch_id(){      
	
	    var strregno ="";
	    strregno = gs_regno_s;
	    /**
	    if(gclx_cocode.bindcolval=="02") strregno = gs_regno_s;
		else if (gclx_cocode.bindcolval=="01") strregno = gs_regno_g;
		else if (gclx_cocode.bindcolval=="03") strregno = gs_regno_g;
		**/
		
		//alert("strregno::"+strregno);
	  
	    gctr_data.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1"
		gctr_data.Parameters = "v_str1="+gusrid+",v_str2="+strregno;
			
		//prompt('gcds_data',gcds_data.text);
	
		gctr_data.post();
	}
	

	
	
	
	
	/******************************************************************************
		Description : 스마트 모듈 호출 
	******************************************************************************/
	function ln_SM_Call(strBatchId, strId, strPass){
	
	      //alert("strBatchId::"+strBatchId+"::STATUS::"+gs_status+"::SIGNAL::"+gs_signal+"::strId::"+strId+"strPass::"+strPass+"::SBDESCRIPTION::"+hid_sbdescription.value);
	    
			var url="";
	        var v_left = (screen.width-300)/2;
	        var v_top  = (screen.height-300)/2;
	
			if (gs_sm_call_status=="V"){   //세금계산서 보기 및 출력
					url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";			
					window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top  );
					ln_Query();
	    	}
	    	
	}



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>



<object  id=ds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id="ds_fdcode" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[검색] -->
</object> 

<object  id="ds_staxknd" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매입] -->
</object> 


<object id=ds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>




<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=ds_default event=OnLoadCompleted(row,colid)>

		window.status = "정상적으로 조회되었습니다.";
		
		if (row<1) 
			alert("검색된 데이터가 없습니다.");
</script>





<script language="javascript" for="ds_fdcode" event="onloadCompleted(row,colid)">

	ds_fdcode.InsertRow(1);
	
	ds_fdcode.NameValue(1,"FDCODE")="";
	
	ds_fdcode.NameValue(1,"FDNAME")="전체";
	
	lc_fdcode.bindcolval=gs_fdcode;
	
</script>




<script language="javascript" for="ds_staxknd" event="onloadCompleted(row,colid)">

	ds_staxknd.InsertRow(1);
	
	ds_staxknd.NameValue(1,"CDCODE")="";
	ds_staxknd.NameValue(1,"CDNAM")="전체";
	
	ds_staxknd.AddRow();
	
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDCODE")="9";
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDNAM")="세금계산서";

	ds_staxknd.AddRow();
	
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDCODE")="6";
	ds_staxknd.NameValue(ds_staxknd.rowposition,"CDNAM")="세금계산서+기타";

	lc_staxknd.index=0;
	
</script>





<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=gcgd_data  event="OnDblClick(Row,Colid)">

	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	
	arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR");

	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);
	
</script>





<script language="javascript" for="gcgd_data" event="OnClick(row,colid)">
	
		
    if((row!=0) && (colid=="CHK")){
        
	    if(gcds_data.namevalue(row,"CHK")=="T"){
	
	 	}else{
	 	        gcds_data.undo(row);
	 	}
    }   
        
</script>




<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>





</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>


<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">

        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"				style="cursor:pointer" onClick="fnApply();">

						</td>
                    </tr>
                </table>
            </td>
        </tr>

	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>

            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>

                        <td align=left class="text"  width="100">계산서기간</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>           			

                        <td align="left" class="text" width="90">지점코드</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_fdcode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=ComboDataID			value="ds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
	              				<param name=Enable              value="true">
								<param name=ListExprFormat	    value="FDNAME^0^150">
								<param name=BindColumn			value="FDCODE">
								<param name=Index               value="2">                            
                            </object>
                        </td>                         
                               
                        <td align="left" class="text" width="90">사업소</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData				value="^전체,01^고성,02^서울,04^홍성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
                            </object>            
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">거래처</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>
                        
                        
                        <td align="center" class="text" width="90">작성자</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="조회창 팝">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>                        
                        
                        <td align="center" class="text" width="90">eBill구분</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_ebill classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^전체,1^스마트빌,2^트러스빌,9^기타">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                           
                        
					</tr>
					
           			<tr>
                        <td align="center" class="text" width="90">부가세종류</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_staxknd classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
                        
								<param name=ComboDataID			value="ds_staxknd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^150">
								<param name=BindColumn			value="CDCODE">

                            </object>
                        </td>
                        
                        
                        <td align="center" class="text" width="90">전표상태</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_fsstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^전체,Y^결재완료,C^결재취소,R^결재요청,N^결재대기,B^반송,X^결재완료이외">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                        
                        
                        <td align="center" class="text" width="90">발행구분</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
								<param name=CBData					value="^전체,1^전자발행,2^수기발행">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                           
                        
					</tr>

           		</table>
            </td>	
	</tr>
	
	
	
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
  
  
  <tr>
      <td valign="top">
          <table  border='0' cellpadding='0' cellspacing='0'>
              <tr>
                  <td valign='top' width="1000px">
                      <%=HDConstant.COMMENT_START%>
                      <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='550px' border='1'>
                          <param name="DataID"            value="ds_default">
                          <param name="ColSizing"         value="true">
                          <param name="Editable"          value="true">
                          <param name="SuppressOption"    value="1">
                          <param name="BorderStyle"       value="0">
                          <param name="ViewSummary"       value="1">
                          <param name="Format"            value="
							<C>ID=CHK,				Name='선택'				width=30, 	align=center, EditStyle=CheckBox BgColor='#f5f5f5'</C>
							<C>ID=FDNAME, 			Name='지점'				width=30, 	align=left,   Edit=none show=false </C>
							<C>ID=FSNUM,			Name='전표번호'			width=105, 	align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'</C>
							<C>ID=VEND_CD,			Name='거래처코드'		width=80,  	align=center, BgColor='#f5f5f5' Edit=none show=false </C>
				                       
							<C>ID=VEND_NM,			Name='거래처명'			width=95,  	align=LEFT,   BgColor='#f5f5f5' 	Edit=none sort=true </C>
							<C>ID=VEND_ID,			Name='사업자번호'		width=90,  	align=center, mask='XXX-XX-XXXXX'	Edit=none sort=true </C>
				                         
							<C>ID=TAXSUM,			Name='공급가액'			width=85,  align=right   Edit=none sort=true  </C>		                             
							<C>ID=TAXVATAMT,		Name='부가세액'			width=70,  align=right   Edit=none sort=true  </C>
							<C>ID=TAXTOT,			Name='합계금액'			width=90,  align=right   Edit=none sort=true  </C>		                             
				                         
							<C>ID=REMARK,			Name='적요'				width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=TAXKNDNM,			Name='종류'	     		width=45,  align=center  Edit=none sort=true </C>
							<C>ID=GUBUN,    		Name='발행구분'	    	width=75,  align=left    sort=true show=true  EditStyle=Combo Data='1:전자발행,2:수기발행'</C>
							<C>ID=FSSTAT,			Name='전표상태'			width=75,  align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true </C>
							<C>ID=DTI_STATUS, 		Name='상태'				width=75,  align=left    Edit=none sort=true show=false  EditStyle=Combo Data='A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
							<C>ID=TAXPRTYN,			Name='발행여부'			width=75,  align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true </C>

							<C>ID=DEPTNM,			Name='담당부서'			width=75,  align=left    Edit=none sort=true show=true </C>
							<C>ID=EMPNMK,			Name='담당자'			width=75,  align=center  Edit=none sort=true show=true </C>
														
							<C>ID=AMEND_CODE, 		Name='수정코드'			width=75,  align=left    Edit=none sort=true show=false</C>
				
							<C>ID=TAXDAT,   		Name='계산서일자'		width=90,  align=center  Edit=none sort=true show=true   mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,   		Name='외부발행'     	width=80,  align=center  Edit=none sort=true show=false</C>
							<C>ID=TAXDIVNM,			Name='귀속구분'			width=80,  align=LEFT    Edit=none sort=true show=false</C>
							<C>ID=FSDAT,			Name='접수일자'			width=60,  align=center  Edit=none sort=true </C>
							<C>ID=FSNBR,			Name='접수번호'			width=60,  align=center  Edit=none sort=true </C>
							<C>ID=CREATION_DATE,	Name='메일발행일시'		width=150,  align=center Edit=none sort=true show=false</C>
							<C>ID=DUEDATE,  		Name='입금예정일'		width=90,  align=center  Edit=none sort=true show=fals mask='XXXX-XX-XX'</C>
							<C>ID=TAXSTS,	 		Name='결재상태'	  		width=75,  align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true </C>
									                             
                       ">
                      </object>   
                      <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
            </table>
</td>
    </tr>
  
  
  
  
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 