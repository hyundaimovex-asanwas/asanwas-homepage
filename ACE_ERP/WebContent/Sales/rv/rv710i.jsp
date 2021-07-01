<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��/�� ����
 * ���α׷�ID 	 : RV730I
 * J  S  P		 : rm730i
 * �� �� ��		 : RM730I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-07-04
 * �������		 : ��/�� ���� (����Ȳ, ��ȸ, ����, ���, ��������, �ڵ�����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2014-02-06][�ɵ���] �̻��̻�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());		   
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			sBgnDate.text='<%=firstday%>';		
			fnInit();
		}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";   
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //������
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	         msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","1");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
	            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams") + ","
	            + "sCustNm=" + sCustNm.value + ","
	            + "sAcceptNo=" + sAcceptNo.value + ","	            
		         if ( sNotAssignYn.checked == true ) {
		            param += "sNotAssignYn=Y";
        	    } else {
	        	    param += "sNotAssignYn=N";            
	            }
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ���ð�, ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS3=ds3,O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text + ","	            
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time");			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  
	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sDepartDate=" + sBgnDate.text + ","	
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","        
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         msgTxt.innerHTML="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();		
			msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	/*
	 * ��������
	 */
	function fnEraser() {
		for( i=1; i<=ds1.CountRow; i++ ) {
			ds1.namevalue(i,"class") = '';		
			ds1.namevalue(i,"teams") = '';
		}
	}		
	/*
	 * �ڵ�����
	 */
	function fnAuto() {
		if ( sAssignYn.checked == true ) {	//������ο� ����	
	        msgTxt.innerHTML="�ڵ����� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
			ds1.undoall();	        
			var teams=1;   
			var count=1;     
			ds1.ResetStatus();         
			for( i=1;i<=ds1.CountRow;i++ ) {
				if ( ds1.RowStatus(i) == 0 ) {
					for ( j=i;j<=ds1.CountRow;j++ ) {
						if ( ds1.RowStatus(j) == 0 && ds1.namevalue(j,"class") == '' && ds1.namevalue(j,"teams") == '' ) {
							if ( ds1.namevalue(j,"cust_gu") == '1' ) {	//���� ������ �ϰ��
								if ( ds1.namevalue(i,"default_class") == ds1.namevalue(j,"default_class") ) {
									ds1.namevalue(j,"class") = ds1.namevalue(j,"default_class");							
									ds1.namevalue(j,"data_modify") = 'T';		
									if ( sTeamsNum.text != '' ) {
										if ( teams < 10 )
											ds1.namevalue(j,"teams") = "0"+teams;				
										else
											ds1.namevalue(j,"teams") = teams;
										if ( (count%eval(sTeamsNum.text)) == 0 )						
											teams++;			
										count++;
									} else {
										if ( teams < 10 )
											ds1.namevalue(j,"teams") = "0"+teams;				
										else
											ds1.namevalue(j,"teams") = teams;
										teams++;			
									}							
								}
							} else if ( ds1.namevalue(j,"cust_gu") == '2' ) {	//���� ����� �ϰ��
								ds1.namevalue(j,"data_modify") = 'T';							
								ds1.namevalue(j,"class") = ds1.namevalue(j,"default_class");
								ds1.namevalue(j,"teams") = ds1.namevalue(j,"default_teams");								
							}
						}
					}				
				}
			}
	        msgTxt.innerHTML="�ڵ������� �Ϸ�Ǿ����ϴ�.";		
		} else {
	        msgTxt.innerHTML="�ڵ����� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
			ds1.undoall();	
			for( k=1; k<=ds1.CountRow; k++ ) {
				ds1.namevalue(k,"data_modify") = '';		
			}			
			var teams=(sTeamsNo.Text=="") ? 0 : sTeamsNo.Text;
			var count=1;        			
			ds1.ResetStatus();  
			for( i=1;i<=ds1.CountRow;i++ ) {
				teams=1;
				count=1;
				if ( ds1.RowStatus(i) == 0 ) {
					for ( j=i;j<=ds1.CountRow;j++ ) {
						if ( ds1.RowStatus(j) == 0 ) {
							if ( ds1.namevalue(j,"cust_gu") == '1' ) {	//���� ������ �ϰ��													
								if ( ds1.namevalue(i,"default_class") == ds1.namevalue(j,"default_class") ) {
									ds1.namevalue(j,"class") = ds1.namevalue(j,"default_class");					
	//								alert("i,j="+i+","+j+"&class="+ds1.namevalue(j,"class"));								
									ds1.namevalue(j,"data_modify") = 'T';		
									if ( sTeamsNum.text != '' ) {
										if ( teams < 10 )
											ds1.namevalue(j,"teams") = "0"+teams;				
										else
											ds1.namevalue(j,"teams") = teams;
										if ( (count%eval(sTeamsNum.text)) == 0 )						
											teams++;			
										count++;
									} else {
										if ( teams < 10 )
											ds1.namevalue(j,"teams") = "0"+teams;				
										else
											ds1.namevalue(j,"teams") = teams;
										teams++;			
									}							
								}
							} else if ( ds1.namevalue(j,"cust_gu") == '2' ) {	//���� ����� �ϰ��
								ds1.namevalue(j,"data_modify") = 'T';							
								ds1.namevalue(j,"class") = ds1.namevalue(j,"default_class");
								ds1.namevalue(j,"teams") = ds1.namevalue(j,"default_teams");	
							}
						}
					}				
				}
			}
	        msgTxt.innerHTML="�ڵ������� �Ϸ�Ǿ����ϴ�.";		
		}
        /////////////////////////////////////////////////////////////////////////////////////		
/*		var teams=1;
		for( i=1; i<=ds1.CountRow; i++ ) {
			if ( sAssignYn.checked == true ) {	//������ο� ����
				if ( ds1.namevalue(i,"class") != '' && ds1.namevalue(i,"teams") != '' ) {
				} else { 
					ds1.namevalue(i,"class") = ds1.namevalue(i,"default_class");
					if ( sTeamsNum.text > i )
						ds1.namevalue(i,"teams") = "01";
					else {
						if ( teams < 10 )
							ds1.namevalue(i,"teams") = "0"+teams;				
						else
							ds1.namevalue(i,"teams") = teams;
						teams++;						
					}
				}
			} else {
				ds1.namevalue(i,"class") = ds1.namevalue(i,"default_class");
				if ( sTeamsNum.text != '' ) {
					if ( teams < 10 )
						ds1.namevalue(i,"teams") = "0"+teams;				
					else
						ds1.namevalue(i,"teams") = teams;
					if ( (i%eval(sTeamsNum.text)) == 0 )						
						teams++;			
				} else {
					if ( teams < 10 )
						ds1.namevalue(i,"teams") = "0"+teams;				
					else
						ds1.namevalue(i,"teams") = teams;
					teams++;			
				}
			}
		} */
	}
	/*
	 *  �˾� 
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	function fnPopup() {   
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv006h.jsp?sSaupSid="+ds2.namevalue(ds2.rowposition,"saup_sid")+"&sDepartDate="+sBgnDate.text+"&sDepartTime="+ds3.namevalue(ds3.rowposition,"depart_time")+"&sGoodsSid="+ds4.namevalue(ds4.rowposition,"goods_sid");
		strPos = "dialogWidth:495px;dialogHeight:379px;status:1;scroll:no;resizable:1";


//		arrResult = window.showModelessDialog(strURL,arrParam,strPos);	
		window.open(strURL,arrParam,'width=495,height=379,scrollbars=no,resizable=1,status=no');		

	} 	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( div != 'init' ) {	//�������
				if ( sBgnDate.Modified ) {
					div = 'init';
					fnSelectDs3();			
				}
			}				
		</script>

		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div != 'init' ) {	//����
				div = 'init';			
				fnSelectDs3();
			}
		</script>	
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div != 'init' ) {	//���ð�
				div = 'init';					
				fnSelectDs6();		
			}
		</script>	
		
        <script language=JavaScript for= lc3 event=OnSelChange()>
            if ( div != 'init' ) {  //��ǰ
                div = 'init';                   
                fnSelectDs6();      
            }
        </script>       
        
		<script language=JavaScript for= lc5 event=OnSelChange()>
			if ( div != 'init' ) {	//��
				div = 'init';					
				fnSelectDs7();		
			}
		</script>		
		
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && ( colid=='class' || colid=='teams' ) ) {
			   	for(i=1;i<=ds1.CountRow;i++)
					ds1.namevalue(i,colid) = ds1.namevalue(1,colid);			   		
		   }		
		</script>		

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);              
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        //�����޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);     
		    
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);  		          
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);           
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);   
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr4.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr4.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr4.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg); 
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	totalNum.value = ds1.CountRow;
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
		fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		fnSelectDs6();
</script>

<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
		fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/class_condition.gif"   	style="cursor:pointer" onclick="fnPopup()">
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"  onclick="fnCancel()">
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr height="50px">
					<td align="left"  colspan='2' width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text" width="70">����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left class="text"  width="70"><b>�������</b></td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
  												<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Format 		value="0000-00-00">
													<param name=Cursor	 	value="iBeam">
													<param name=Border	 	value="false">		
													<param name=InheritColor      value="true">																																																				
													<param name=ReadOnly  	value="false">
													<param name=SelectAll  	value="true">
													<param name=SelectAllOnClick  	value="true">		
													<param name=SelectAllOnClickAny  	value="false">																																																																																																																																												
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="depart_time">
                                                    <param name=BindColVal      value="depart_time">
													<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^50"></object>
												<%=HDConstant.COMMENT_END%>																				
											</td>																							
			            					<td align=left class="text" width="70">��ǰ����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="goods_sid">
                                                    <param name=BindColVal      value="goods_sid">
													<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^140"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;	
											</td>
			            					<td align=left class="text" width="70">��/��</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc5 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="class">
                                                    <param name=BindColVal      value="class">
													<param name=EditExprFormat	value="%,%;class,class_nm">
													<param name=ListExprFormat  value="class_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>	
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc6 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
													<param name=BindColumn      value="teams">
                                                    <param name=BindColVal      value="teams">
													<param name=EditExprFormat	value="%,%;teams,teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>																					
											</td>											                            
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
		            						<td align=left class="text" width="70">������</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
					                            <object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>		
											</td>	
		            						<td align=left class="text" width="70">����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
												<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">	
											</td>	
		            						<td align=left class="text" width="70">��û����ȣ</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
												<input id="sAcceptNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">	
											</td>																				
		            						<td align=left class="text" width="70">�̹�����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
												<input name='sNotAssignYn' type='checkbox' value='Y'>																				
											</td>																				
			            				</tr>		
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="0">
					<td colspan='2'></td>
				</tr>													
				<tr height="45px">
					<td align="right" width="700px">
						<table width='180' border='0' cellpadding='0' cellspacing='0' style='border:1px solid #6f7f8d;height:30'>
							<tr >
								<td width='100' height='20'>
									<table width='100' border='0' cellspacing='0' cellpadding='0'>
										<tr >
											<td style= "position:relative;left:-0px;top:2px;width:50px; height:20px;">&nbsp;���ο�</td>
											<td>
  												<%=HDConstant.COMMENT_START%>
  												<object id=sTeamsNum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 valign=middle align=center class="textbox">			
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Numeric value="true">
													<param name=Cursor	 	value="iBeam">
													<param name=Format   value="0000">																					
													<param name=IsComma   value="false">
													<param name=Border	 	value="0">		
													<param name=InheritColor      value="true">																																																				
													<param name=ReadOnly  	value="false">
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>																			
										</tr >
									</table>							
								</td>		
								<td width='10'>&nbsp;</td>
								<td width='100' height='20'>
                                    <table width='100' border='0' cellspacing='0' cellpadding='0'>
                                        <tr >
                                            <td style= "position:relative;left:-0px;top:2px;width:50px; height:20px;">&nbsp;������</td>
                                            <td>
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=sTeamsNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 valign=middle align=center class="textbox">          
                                                    <param name=Text        value="">
                                                    <param name=Alignment   value=1>
                                                    <param name=Numeric value="true">
                                                    <param name=Cursor      value="iBeam">
                                                    <param name=Format   value="0000">                                                                                  
                                                    <param name=IsComma   value="false">
                                                    <param name=Border      value="0">      
                                                    <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                                    <param name=ReadOnly    value="false">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>                                                                           
                                        </tr >
                                    </table>                            
                                </td>       
                                <td width='10'>&nbsp;</td>
                                <td width='100' height='20'>
									<table width='100' border='0' cellspacing='0' cellpadding='0'>
										<tr >
											<td ><input name='sAssignYn' type='checkbox' value='Y'>���������</td>
										</tr >
									</table>							
								</td>
							</tr>
						</table>
					</td>	
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/class_delete.gif"   	style="cursor:pointer" onclick="fnEraser()">
									<img src="<%=dirPath%>/Sales/images/auto_assign.gif"		style="cursor:pointer" onClick="fnAuto();">																			
					 			</td>
							</tr>	
						</table>
					</td>														
				</tr>												
				<tr>
					<td width="845px" colspan='2'>
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:845px; height:420" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>	
										<param name=ViewSummary  value="1">
										<param name="Format" 			value="
                                           <C> name='No'             ID='{STRING(CURROW)}'           Width=40 BgColor=#996699   align=center</C>																		
							                <C> name='�ݡ�'        ID='class'       width=30 align=right editlimit=2 show=true</C>
							                <C> name='����'        ID='teams'      width=30  align=right editlimit=2 show=true</C>
							                <C> name='DEFAULT��'        ID='default_class'       align=left editlimit=3 show=FALSE</C>
							                <C> name='DEFAULT��'        ID='default_teams'       align=left editlimit=3 show=FALSE</C>

							                <C> name='��û����ȣ'    ID='accept_no'  BgColor=#fefec0 width=100 align=center editlimit=15 edit=none show=true suppress=1 sumtext=@count</C>
							                <C> name='���ð�'    ID='depart_time'  BgColor=#fefec0 width=55 align=center editlimit=15 edit=none show=true  suppress=2 sumtext=��</C>
							                <C> name='��ǰ��'    ID='goods_nm'  BgColor=#fefec0 width=95 align=left editlimit=15 edit=none show=true  suppress=3</C>															                															                
							                <C> name='����Ÿ��' ID='room_type_cd'   BgColor=#fefec0  width=55   align=center editlimit=10  edit=none show=true  suppress=4</C>
							                <C> name='����'      ID='cust_nm'   BgColor=#fefec0  width=50 align=left editlimit=30  edit=none show=true sort=true</C>
							                <C> name='�ֹι�ȣ'    ID='manage_no'  BgColor=#fefec0 width=90  align=center editlimit=20  edit=none show=true </C>
							                <C> name='����'       ID='sex_nm'   BgColor=#fefec0   width=30 align=center editlimit=50  edit=none show=true</C>
							                <C> name='��������'   ID='join_cd_nm' BgColor=#fefec0 width=50 align=left editlimit=50  edit=none show=true</C>
							                <C> name='�������ڵ�'   ID='cust_gu' BgColor=#fefec0 width=50 align=left editlimit=50  edit=none show=false</C>															                
							                <C> name='������'   ID='cust_gu_nm' BgColor=#fefec0 width=50 align=left editlimit=50  edit=none show=true  suppress=5</C>
							                <C> name='�����'   ID='company_nm' BgColor=#fefec0 width=80 align=left editlimit=30  edit=none show=true</C>
							                <C> name='����'    ID='positions'  BgColor=#fefec0 width=50 align=left editlimit=30  edit=none show=true</C>
							                <C> name='�ּ�'     ID='address1'   BgColor=#fefec0 width=170 align=left editlimit=60  edit=none show=true</C>
							                <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
							                <C> name='data_modify'        ID='data_modity'       align=left editlimit=3 show=false</C>															                
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>

		</td>
	</tr>
	
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

