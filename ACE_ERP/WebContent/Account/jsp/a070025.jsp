<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 기타업체대금지급
+ 프로그램 ID: a070025.jsp
+ 기 능 정 의	: 협력업체대금지급
+ 작  성   자  : 정 영 식
+ 작 성 일 자 : 2017.11.17
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자  : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a070025_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>기타업체대금지급</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_save_gubun="";
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode= gfdcode;


<%
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gclx_fdcode.bindcolval="02";

	gcem_actyymm.text =fnGetbyymm(gs_date2);
	gcem_actyymm_to.text =fnGetbyymm(gs_date2);		
	gcem_caldat.text = gs_date;
	gcem_paydat_fr.text = gs_date2+"01";
	gcem_paydat_to.text = gs_date;
	
	gcem_fuldat.text = "";
	
	gcrd_gubun.codevalue="1";
	gcrd_cash_bill_gb.codevalue="3";
	
	gcrd_view_gb.codevalue ="2";
	
	ln_gcrd_view_gb();
	
	ln_Button_Display();
	
	//gcds_code01.SubsumExpr = "1:VENDCD";
 }
 
 <%
 //****************************************************************************
// 전월구하기
//****************************************************************************
%>
function fnGetbyymm(v_yyyymm) {

	var ls_yy = v_yyyymm.substring(0,4);
	var ls_mon = v_yyyymm.substring(4,6);
	var ls_bef_yyyymm="";
	var mm=0;
	
	if (ls_mon == "01") {
		ls_bef_yyyymm = parseInt(ls_yy,10)-1;
		ls_bef_yyyymm = ls_bef_yyyymm+"12";
	}else {
        mm =  parseInt(ls_mon,10)-1;
        if(mm<10){
        	ls_bef_yyyymm = ls_yy+"0"+mm;
        }else{
            ls_bef_yyyymm = ls_yy+mm;
        }
	}
	return(ls_bef_yyyymm);
}	

<%
/******************************************************************************
	Description : 삭제버튼 Display
******************************************************************************/
%>
function ln_Button_Display(){
	if(gcrd_gubun.codevalue=="1"){
		sp0.style.display = "none";
	}else if (gcrd_gubun.codevalue=="2"){
	    sp0.style.display = "";
	}
}

<%
/******************************************************************************
	Description : 조회
	//검색조건
    //저장전 -   지점, 회계년월, 정산일자
    //저장후 -   지점, 회계년월, 지급일자  
******************************************************************************/
%>
function ln_Query(){ 

    //필수항목 체크하기 
    //지점 
    if(gclx_fdcode.bindcolval==""){
    	alert("지점을 입력하십시요");
    	return false;
    }
    
    //회계년월
    if(gcem_actyymm.text==""){
    	alert("회계년월을 입력하십시요");
    	return false;
    }
    
    if(gcrd_gubun.codevalue=="1"){            //저장전 
    
    	//정산일자 체크 
    	  if(gcem_caldat.text==""){
		    	alert("정산일자를  입력하십시요");
		    	return false;
		  }

        //GRID의 EDIT 품 
        gcgd_disp01.ColumnProp('PAYDAT', 'Edit')="Any";
        gcgd_disp01.ColumnProp('CHKCASH', 'Edit')="Any";
        gcgd_disp01.ColumnProp('CHKBILL', 'Edit')="Any";
        gcgd_disp01.ColumnProp('FULDAT', 'Edit')="Any";
    	
    	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_s1"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+gcem_actyymm.text           
										 + "&v_str3="+gcem_actyymm_to.text
										 + "&v_str4="+gcem_caldat.text
										 + "&v_str5="+txt_vendcd.value             
		 								 + "&v_str6="+txt_vendnm.value;       	
		 // prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else if (gcrd_gubun.codevalue=="2"){ //저장후
	
	   // 지급일자 체크  
    	  if(gcem_paydat_fr.text==""||gcem_paydat_to.text==""){
		    	alert("지급일자를  입력하십시요");
		    	return false;
		  }
		  
		//GRID의 EDIT 막음   
		gcgd_disp01.ColumnProp('PAYDAT', 'Edit')="none";
        //gcgd_disp01.ColumnProp('CHKCASH', 'Edit')="none";
        //gcgd_disp01.ColumnProp('CHKBILL', 'Edit')="none";
        //gcgd_disp01.ColumnProp('FULDAT', 'Edit')="none";
		  
	    gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_s2"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+gcem_actyymm.text           
										 + "&v_str3="+gcem_paydat_fr.text       
										 + "&v_str4="+gcem_paydat_to.text
										 + "&v_str5="+txt_vendcd.value
										 + "&v_str6="+txt_vendnm.value         
										 + "&v_str7="+gcrd_cash_bill_gb.codevalue
										 + "&v_str8="+gcem_fuldat.text
		 								 + "&v_str9="+gcem_actyymm_to.text;	    
		 // prompt('', gcds_code01.DataID);				
		 gcds_code01.Reset();
	}
}


<%
/******************************************************************************
	Description : 엑셀
******************************************************************************/
%>
function ln_Excel(){
    var strTitle ="협력업체대금지급";

    //gcgd_disp01.SetExcelTitle(1, "value:"+strTitle+"; font-face:±¼¸²u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	gcgd_disp01.GridToExcel(strTitle,"",1);
}

<%
/******************************************************************************
	Description : 저장  
******************************************************************************/
%>
function ln_Save(){
	if(gcds_code01.IsUpdated){
		if(ln_Chk()){
		     if(confirm("협력업체 대금지급 내용을  저장하시겠습니까?")){
					gctr_code01.KeyValue = "Account.a070025_t1(I:USER=gcds_code01)";
					gctr_code01.Action      = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_t1?";
					gctr_code01.Parameters="v_str1="+gusrid+",v_str2="+gcds_code01.namevalue(1,"GUBUN");
					//prompt('',gcds_code01.text);
					gctr_code01.post();
			}
		}
	}
}



<%
/******************************************************************************
	Description : 저장시 체크   
******************************************************************************/
%>
function ln_Chk(){

   // alert("체크시작 ");
   // CHK :: 추가함
   
	
	for ( var i =1;i<=gcds_code01.countrow;i++){
	
		if(gcds_code01.RowLevel(i)==0){ //데이터 소계아님. ...
	
			//저장전 
			//필수항목 체크 
			//지급일자, 현금, 어음, 만기일자 
			//현금인데 만기일자 있으면 체크 
			
			//alert("gcrd_gubun.codevalue:::"+gcrd_gubun.codevalue);
			if(gcrd_gubun.codevalue=="1"){
		
				if(gcds_code01.namevalue(i,"CHK")=="T"){
				   
					 if(gcds_code01.namevalue(i,"GUBUN")!="A"){
							alert("저장전 데이터가 아닙니다. 확인 하십시요. ");
							return false;
					 }
					
					if(gcds_code01.namevalue(i,"PAYDAT")==""){
						alert( i+"행의 지급일자를 입력 하십시요. ");
						return false;
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")==""||gcds_code01.namevalue(i,"CHKCASH")=="F"){
						if(gcds_code01.namevalue(i,"CHKBILL")==""||gcds_code01.namevalue(i,"CHKBILL")=="F"){
							alert( i+"행의 현금 또는 어음을 체크하십시요. ");
							return false;
						}			
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"&&gcds_code01.namevalue(i,"CHKBILL")=="T"){
						alert( i+"행의 현금과  어음이 모두 체크 되었습니다. 확인하십시요. ");
						return false;
					}
					
					
					//저장전 데이터를 저장할 경우 만기일자는  체크 하지 않음. 
					/** 
					if(gcds_code01.namevalue(i,"CHKBILL")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")==""){
							alert( i+"행이 어음일 경우 만기일자를 입력하십시요. ");
							return false;
						}
					}
					**/
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")!=""){
							alert( i+"행이 현금인 경우 만기일자가 존재하지 않아여 합니다. ");
							return false;
						}
					}
				}else{
					gcds_code01.Undo(i);
				}
			}
			
			//저장후 
			//삭제 버튼은 화면에서 삭제 표기 후 저장 
			if(gcrd_gubun.codevalue=="2"){
			
				if(gcds_code01.namevalue(i,"CHK")=="T"){
				    if(gcds_code01.namevalue(i,"GUBUN")!="B"){
						alert("저장후  데이터가 아닙니다. 확인 하십시요. ");
						return false;
				    }			
				    
				    if(gcds_code01.namevalue(i,"CHKCASH")==""||gcds_code01.namevalue(i,"CHKCASH")=="F"){
						if(gcds_code01.namevalue(i,"CHKBILL")==""||gcds_code01.namevalue(i,"CHKBILL")=="F"){
							alert( i+"행의 현금 또는 어음을 체크하십시요. ");
							return false;
						}			
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"&&gcds_code01.namevalue(i,"CHKBILL")=="T"){
						alert( i+"행의 현금과  어음이 모두 체크 되었습니다. 확인하십시요. ");
						return false;
					}
				    
				    //만기일자 체크 
				    if(gcds_code01.namevalue(i,"CHKBILL")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")==""){
							alert( i+"행이 어음일 경우 만기일자를 입력하십시요. ");
							return false;
						}
					}
					
					if(gcds_code01.namevalue(i,"CHKCASH")=="T"){
						if(gcds_code01.namevalue(i,"FULDAT")!=""){
							alert( i+"행이 현금인 경우 만기일자가 존재하지 않아여 합니다. ");
							return false;
						}
					}
				}else{
					gcds_code01.Undo(i);
				}
			}
		}//RowLevel
    }//for
	return true;
}

<%
/******************************************************************************
	Description : 삭제  
******************************************************************************/
%>
function ln_Delete(){
	
	//삭제 체크 
	if(gcds_code01.namevalue(1,"GUBUN")!="B"){
		alert("저장 후만 삭제 가능합니다.");
		return false;
	}
		
	if(gcds_code01.RowLevel(gcds_code01.rowposition)!=0){ 
		alert(gcds_code01.rowposition+ " 행은 삭제 가능건이 아닙니다.");
		return false;
	}
	
	gcds_code01.DeleteRow(gcds_code01.rowposition);

	if(gcds_code01.IsUpdated){
		if(confirm(" 삭제 하시겠습니까?")){
			gctr_code01.KeyValue   =  "Account.a070025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070025_t1?";
			//prompt('',gcds_code01.text);
			gctr_code01.post();
		}
	}
}


<%
/******************************************************************************
	Description : 지급일자 일괄변경   
******************************************************************************/
%>
function ln_ChgDate_Batch(){
   
    //저장전인지 체크 
    //삭제 체크 
	if(gcds_code01.namevalue(1,"GUBUN")!="A"){
		alert("저장 저장전만 지급일자 일괄 변경 가능합니다.");
		return false;
	}
   
	if(gcem_paydat_0.text==""){
		gcem_paydat_0.focus();
		alert("변경할 지급일자를 입력하십시요");
		return;
	}
	
	//alert(":::::::::::::::"+gcem_paydat_0.text+"::::::::::::::::::::::"+gcem_paydat_0.text.length);
	
	var str = gcem_paydat_0.text;
	str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
	gcem_paydat_0.text = str;
	
	if(gcem_paydat_0.text.length!=8){
		gcem_paydat_0.focus();
		alert("변경할 지급일자를 확인하십시요");
		return;
	}
		
	
	for (var i=1;i<=gcds_code01.countrow;i++){
		//저장전 데이터인지 체크 
		//if(gcds_code01){	
		//}
		
		gcds_code01.namevalue(i,"PAYDAT") = gcem_paydat_0.text;
	
	}
}


<%
/******************************************************************************
	Description : 현금어음선택 
******************************************************************************/
%>
function ln_CashBill_Sel(row, colid){
	if(colid == "CHKCASH"){
	    gcds_code01.namevalue(row, "CHKCASH") ="T";
		gcds_code01.namevalue(row, "CHKBILL") ="F";
	}else if(colid == "CHKBILL"){
	    gcds_code01.namevalue(row, "CHKBILL") ="T";
		gcds_code01.namevalue(row, "CHKCASH") ="F";
	}
}

<%
/******************************************************************************
	Description : 거래처 
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vendnm.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vendcd.value = arrParam[0];
		 txt_vendnm.value = arrParam[1];
	} else {
		 txt_vendcd.value = "";
		 txt_vendnm.value = "";
    }
}


function ln_gcrd_view_gb(){
	if(gcrd_view_gb.CodeValue=="1"){
		gcds_code01.SubsumExpr = "1:VENDCD";
	}else if(gcrd_view_gb.CodeValue=="2"){
	    gcds_code01.SubsumExpr = "";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!-- 대금지급 -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>



<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a0900033_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "조회건수 : " + gcds_code01.RealCount(1,row) + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_code01.countrow<=0)
		alert("조회된 데이타가 없습니다.");
</script>


<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
   /*
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
	*/
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcrd_gubun  event=OnSelChange()>
	ln_Button_Display();
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

     if(gcds_code01.namevalue(1,"GUBUN")=="A"){
	    if(row>0){
	    	ln_CashBill_Sel(row,colid);
	    }else if (row==0){
	    	if(colid=="CHKCASH"){
	    		for(var i=1;i<=gcds_code01.countrow;i++){
	    			 gcds_code01.namevalue(i, "CHKBILL") ="F";
					 gcds_code01.namevalue(i, "CHKCASH") ="T";
	    		}
	        }else if(colid=="CHKBILL"){
	        	for(var i=1;i<=gcds_code01.countrow;i++){
	    			 gcds_code01.namevalue(i, "CHKBILL") ="T";
					 gcds_code01.namevalue(i, "CHKCASH") ="F";
	    		}
	        }
	    }
	 }
    
    

 </script>


<script language=JavaScript for=gcgd_disp01 event=onKeyPress(keycode)>

    /**
    alert("gcds_code01.Countindex:"+gcds_code01.Countindex);
    alert(gcds_code01.ColumnInex(gcds_code01.Countindex) );

	if(keycode==32) { //스페이스바 
		var row = gcds_code01.rowposition;
		//var colid = gcds_code01.rowposition  
		//ln_CashBill_Sel(row);
	}
	**/
 </script>
 

<script language=JavaScript for=gcrd_view_gb event=OnSelChange()>

		ln_gcrd_view_gb();
		
</script>

<script language=JavaScript for=gcrd_cash_bill_gb event=OnSelChange()>

		if(gcrd_cash_bill_gb.CodeValue=="1"){
			gcem_fuldat.text = "";
		}
		
</script>



 
<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
    alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif" height="40px" align=left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;" onclick="ln_Excel()"> 
		    <img src="../../Common/img/btn/com_b_save.gif"	   style="cursor:hand"  onClick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="160px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID		 value="gcds_fdcode">
				<param name=CBDataColumns	 value="FDCODE, FDNAME">
				<param name=SearchColumn	 value=FDNAME>
				<param name=ListExprFormat	 value="FDNAME^0^120">
				<param name=BindColumn		 value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> 회계년월</td>  
	    <td width="250px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text		   value="">
				<param name=Alignment      value=0>
				<param name=Border         value=true>
				<param name=Format         value="YYYY/MM">
				<param name=PromptChar     value="_">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor   value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
			~
			<comment id="__NSID__">
			<object id=gcem_actyymm_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text			value="">
				<param name=Alignment       value=0>
				<param name=Border          value=true>
				<param name=Format          value="YYYY/MM">
				<param name=PromptChar      value="_">
				<param name=BackColor       value="#CCCCCC">
				<param name=InheritColor    value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  

		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>거래처</td> 
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vendnm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:120px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vendcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
			
		</td>
	</tr>
	
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >구분</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:120">
					<param name=Cols	    value="2">
					<param name=Format	value="1^저장전 ,2^후">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >정산일자</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_caldat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_caldat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>지급일자</td> 
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		 value=0>
			<param name=Border	         value=true>
			<param name=Format	         value="YYYY/MM/DD">
			<param name=PromptChar	 value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
			<span id=sp0 style="display:none;">
				<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;left:90px;>"       onClick="ln_Delete()">
			</span>
		</td>
	</tr>
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >지급구분</td>
		<td class="tab28"   >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_cash_bill_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:140">
					<param name=Cols	    value="3">
					<param name=Format	    value="1^현금,2^어음,3^전체">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >어음만기일자</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_fuldat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	      value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fuldat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >SubSum View </td>
		<td class="tab28"   >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_view_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:180">
					<param name=Cols	    value="2">
					<param name=Format	    value="1^Display,2^NonDisplay">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr>
		<td colspan =8  align="right">
			 <font style="position:relative;top:-4px;left:0px">일괄변경 지급일자</font>&nbsp;
				 <comment id="__NSID__">&nbsp;
				 <object id=gcem_paydat_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
				 <param name=Text				 value="">
				 <param name=Alignment       value=0>
				 <param name=Border          value=true>
				 <param name=Format          value="YYYY/MM/DD">
				 <param name=BackColor       value="#CCCCCC">
				 <param name=InheritColor    value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
			  <img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_paydat_0', 'Text')" style="position:relative;width:20px;left:0px;cursor:hand;">
			 <img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;left:0px" onClick="ln_ChgDate_Batch()">
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;width:998px; height:450px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="20">
					<param name=UsingOneClick     value="1">
					<param name=ViewSummary       value="1">
					<param name="Format"		  value=" 			
					<C> Name='LV'			      	ID=CurLevel			HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  Value={CurLevel} show=false</C>
					<C> Name='선택'          	  	ID=CHK      	    HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''      sort=true    EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='순번'			      	ID=Currow		    HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  Value={CurRow}  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}   </C>
					<C> Name='구분'			      	ID=GUBUN		    HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false</C>
					<C> Name='계정코드'			  	ID=ATCODE		    HeadAlign=Center HeadBgColor=#B9D4DC Width=53 	align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false</C>
					<C> Name='계정명' 			  	ID=ATKORNAM		    HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=left     SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  show=false </C>
					<C> Name='거래처'	                ID=VENDCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center   SumBgColor=#C3D0DB sumtext=''      sort=true    edit=none   SumTextAlign=center  Value={Decode(CurLevel,2,'',0,VENDCD)}  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} Color={Decode(CREDGB,1,'red',2,'red','black')}  </C>
					<C> Name='거래처명'			  	ID=VENDNM		    HeadAlign=Center HeadBgColor=#B9D4DC Width=110  align=left     SumBgColor=#C3D0DB sumtext=''      sort=true     edit=none  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}  Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C> Name='지급금액'               ID=JANAMT      	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=right	   SumBgColor=#C3D0DB sumtext='@sum'  sort=true    edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}  Color={Decode(CREDGB,1,'red',2,'red','black')}  </C>
					<C> Name='회계일자'	          	ID=ACTDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69 	align=center   SumBgColor=#C3D0DB sumtext=''   edit=none   MASK='XXXX/XX/XX'  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='세금계산서'     		    ID=TAXDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69	align=center   SumBgColor=#C3D0DB sumtext=''   edit=none   MASK='XXXX/XX/XX'  BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='지급일자'               ID=PAYDAT			HeadAlign=Center HeadBgColor=#B9D4DC Width=69	align=center   SumBgColor=#C3D0DB sumtext=''   MASK='XXXX/XX/XX'      HeadCheck=true   HeadCheckShow=true     BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='적요'	        	  	ID=REMARK   		HeadAlign=Center HeadBgColor=#B9D4DC Width=280  align=left     SumBgColor=#C3D0DB sumtext=''   sort=true    BgColor={IF(CurLevel=1, '#5FB404', IF(FSLOCK='T','YELLOW', '#FAFAFA'))} Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C> Name='현금'          	  	ID=CHKCASH    	    HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='어음'          	  	ID=CHKBILL      	HeadAlign=Center HeadBgColor=#B9D4DC Width=28   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   EditStyle=CheckBox   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='만기일자'		      	ID=FULDAT     		HeadAlign=Center HeadBgColor=#B9D4DC Width=69   align=center   SumBgColor=#C3D0DB sumtext=''   sort=true   MASK='XXXX/XX/XX'    BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='접수일자'			  	ID=FSDAT 			HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='접수번호'			  	ID=FSNBR			HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='상태'		    	  	ID=FSSTAT           HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   EditStyle=Combo Data='Y:결재완료,R:결재요청,N:결재대기,C:결재취소,B:반송' BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))} show=false</C>
					<C> Name='담당자'		        	ID=EMPNMK           HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='잠금'		        	ID=FSLOCK           HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='잠금전표일자'		    ID=SSDAT            HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					<C> Name='잠금전표번호'		    ID=SSNBR            HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   BgColor={IF(CurLevel=1, '#5FB404',IF(FSLOCK='T','YELLOW', '#FAFAFA'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 