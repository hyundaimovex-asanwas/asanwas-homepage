<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 자동전표 분개정의
 * 프로그램ID 	 : PMS/Sta
 * J  S  P		 : Sta010.jsp
 * 서 블 릿		 : Sta010
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-15
 * 기능정의		 : 자동전표 분개정의
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

		fnSelect();
        
    }
    
    <%//메인 조회  %>
    function fnSelect() {
    	
		    v_job="S";


	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  								+ ",v_journal="  + v_journal.value;
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta010",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    
    

	<%//승인 %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_default.IsUpdated) {
			
			  ln_TRSetting(tr1, 
					  
                "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm030",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
			  
			   //prompt(this, ds_default.text);
			  
			   tr_post(tr1);

        }else{
        	
     		alert("승인할 코드를 선택해주시기 바랍니다.");
		
        }
		
		
	 }


</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>




<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		alert("성공적으로 승인되었습니다.");
		fnSelect();
	}
	
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
    
    
</script>


<script language=JavaScript for=tr1 event=OnFail()>
alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
    </script>
 
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
	
        msgTxt.innerHTML="조회가 완료 되었습니다.";

	</script>
	

	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
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

</head>


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"				style="cursor:pointer" onClick="fnApply();">

						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1000px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
                    			<tr>
			                        <td align=left class="text"  width="70">분개정보</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_journal' id="v_journal" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                               
			                        </td>		                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
								<C> Name='순번'       	ID=SORTSEQ         Width=30 	    align=center  	    </FC>
								<G> Name='분개정보'     
									<C> Name='분개NO'  		ID=JOUNO	         Width=50     	align=center 	  EditStyle=Popup</C>
								    <C> Name='분개명'	  	ID=JOU_NAME	   	  	Width=100  	    align=left  	  edit=none  bgcolor='#eeeeee'</C>
								</G>
								
								<G> Name='계정정보'	  
								<C> Name='코드'	     		ID=ATCODE 	         Width=50     	align=center 	  EditStyle=Popup</C>
								<C> Name='계정명'	     	ID=ATKORNAM	   		 Width=100  	align=left  	  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='차대'	     		ID=ATDECR  	   		 Width=50    	align=center 	  EditStyle=Combo, Data='1:차변,2:대변'</C>
								<C> Name='체크'  	 		ID=ACCCHK		     Width=30    	align=left  	  </C>
								<C> Name='체크명'  	 		ID=CHKNAME  	     Width=100    	align=left  	  </C>
								</G>
								
								<G> Name='거래처정보'     
								<C> Name='코드'	      		ID=VENDCD	         Width=55    	align=center	  EditStyle=Popup </FC>
								<C> Name='거래처명'	  		ID=VENDNM 	     	Width=100    	align=left  	  edit=none bgcolor='#eeeeee'</FC>
								</G>
								
								<G> Name='세목정보(관리항목)'	   
								<C> Name='코드1'       		ID=FSREFCD1  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명1'     		ID=FSREFCDNM1      		Width=80     	align=left  	   </C>
								<C> Name='항목값1'	  		ID=FSREFVAL1       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명1'	  	ID=FSREFVALNM1     		Width=80    	align=left  	   </C>
								<C> Name='코드2'       		ID=FSREFCD2  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명2'     		ID=FSREFCDNM2      		Width=80     	align=left  	   </C>
								<C> Name='항목값2'	  		ID=FSREFVAL2       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명2'	  	ID=FSREFVALNM2     		Width=80    	align=left  	   </C>
								<C> Name='코드3'       		ID=FSREFCD3  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명3'     		ID=FSREFCDNM3      		Width=80     	align=left  	   </C>
								<C> Name='항목값3'	  		ID=FSREFVAL3       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명3'	  	ID=FSREFVALNM3     		Width=80    	align=left  	   </C>
								<C> Name='코드4'       		ID=FSREFCD4  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명4'     		ID=FSREFCDNM4       	Width=80     	align=left  	   </C>
								<C> Name='항목값4'	  		ID=FSREFVAL4       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명4'	  	ID=FSREFVALNM4     		Width=80    	align=left  	   </C>
								<C> Name='코드5'       		ID=FSREFCD5  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명5'     		ID=FSREFCDNM5       	Width=80     	align=left  	   </C>
								<C> Name='항목값5'	  		ID=FSREFVAL5       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명5'	  	ID=FSREFVALNM5     		Width=80    	align=left  	   </C>
								<C> Name='코드6'       		ID=FSREFCD6  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명6'     		ID=FSREFCDNM6       	Width=80     	align=left  	   </C>
								<C> Name='항목값6'	  		ID=FSREFVAL6       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명6'	  	ID=FSREFVALNM6     		Width=80    	align=left  	   </C>
								<C> Name='코드7'       		ID=FSREFCD7  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='코드명7'     		ID=FSREFCDNM7       	Width=80     	align=left  	   </C>
								<C> Name='항목값7'	  		ID=FSREFVAL7       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='항목값명7'	  	ID=FSREFVALNM7     		Width=80    	align=left  	   </C>
								</G>
								<C> Name='사용\\유무'    	ID=USEGB 	     		Width=50    	align=center	  EditStyle=Combo, Data='T:사용,F:미사용' </C> 
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
    </table>

	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		