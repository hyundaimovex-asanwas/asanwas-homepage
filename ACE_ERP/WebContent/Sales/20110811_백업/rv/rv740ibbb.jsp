<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���ǹ���
 * ���α׷�ID 	 : RV740I
 * J  S  P		 : rm740i
 * �� �� ��		 : RM740I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-07-11
 * �������		 : ���ǹ��� (��ȸ, ����, ���)
 * ��������		 :
 * �� �� ��		 : 
 * ������������        : 
 * TODO			 :
 * TODO			 :
 *****************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�

	// ContextPath
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());		   
%>

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
        var ds10_search = '';
        var Gr2CurRow = 0;	//gr2���� OnClick�� ���õ� �ο�
	/*
	 * �������ε�
	 */
		function fnOnLoad(){
			sBgnDate.text='<%=firstday%>';		
			fnInit();
		}
	/*
	 * ����ȸ --- DS2 : ����, DS5 : ������, DS8 : ��������
	 */
	function fnInit(){
	div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
        cfStyleGrid(getObjectFirst("gr3"), "comn");   
		fnSetHeaderDsInit();                     
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
       ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
            "JSP(O:DS2=ds2,O:DS5=ds5,O:DS8=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeaderDsInit(){
		if (ds10.countrow < 1){
			var s_temp = "use_yn:STRING,accept_no:STRING,cust_nm:STRING,sex_nm:STRING,join_cd:STRING,rsv_sid:INT,m_rsv_sid:INT,room_type_sid:INT,room_sid:INT";
			ds10.SetDataHeader(s_temp);
		}		
	}	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds10.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","1");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
	            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams");
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
	            "JSP(O:DS1=ds1,O:DS9=ds9)",
	            param);
	        tr_post(tr1);
	        ds10_search = "";	        
        }
    }
	/*
	 * ������ȸ(DS1)
	 */
    function fnSelectDS1() {
        v_job = "S";
         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		var Row = ds5.NameValueRow("detail","1");
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sBgnDate=" + sBgnDate.text + ","
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);
        ds10_search = "";	        
    }    
	/*
	 * DS3 : ���ð�, DS4 : ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
	 * DS6 : ����ȸ
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
	 * DS7 : �� ��ȸ
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
	 * Detail ��ȸ
	 */		
	function fnSelectDs10() {
		if (ds10.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
			ds9.rowposition=Gr2CurRow;
		} else {        
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
	            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams") + ","
	            + "sAcceptNo=" + sAcceptNo.value + ","
	            + "sRoomSid=" + ds9.namevalue(ds9.rowposition,"room_sid");	 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
	            "JSP(O:DS10=ds10)",
	            param);
	        tr_post(tr1);
	        ds10_search='true';
			Gr2CurRow = ds9.rowposition;	        
        }
	}			
	/*
	 * ����
	 */
	function fnApply() {
		if (ds10.isUpdated ){ 
			var join_cd_01_count = 0;
			for ( i=1; i<=ds10.CountRow; i++ ) {
				if ( ds10.namevalue(i,"join_cd") == '01' ) 
					join_cd_01_count++;
			}
			if ( ds10.CountRow > 0 ) {
				if ( join_cd_01_count != 1 ) {
					alert("���� �����߿� ������ �ϳ��� ������ ���õǾ�� �մϴ�."); 
					return;
				}
			}
		     v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
	             "JSP(I:DEFAULT=ds10,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated || ds10.IsUpdated ) {
			ds1.undoall();		
			ds10.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	/*
	 *  ������ �̵�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	function fnMove( move_div ) {  
		if ( ds10_search != 'true' )
			alert("���ǿ� ���� ���� ������ ���� ��ȸ�� �ּ���.");
		else {													                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
			if ( move_div == 'R' ) {
				for ( i=1; i<=ds1.CountRow; i++ ) {
					exit='';
					if ( ds1.namevalue(i,"use_yn") == 'T' ) {
						if ( ds10.CountRow < 1 ) {
							ds10.addrow();
							ds10.namevalue(ds10.rowposition,"accept_no") = ds1.namevalue(i,"accept_no");
							ds10.namevalue(ds10.rowposition,"cust_nm") = ds1.namevalue(i,"cust_nm");
							ds10.namevalue(ds10.rowposition,"sex_nm") = ds1.namevalue(i,"sex_nm");
							ds10.namevalue(ds10.rowposition,"join_cd") = ds1.namevalue(i,"join_cd");
							ds10.namevalue(ds10.rowposition,"rsv_sid") = ds1.namevalue(i,"rsv_sid");
							ds10.namevalue(ds10.rowposition,"m_rsv_sid") = ds1.namevalue(i,"m_rsv_sid");
							ds10.namevalue(ds10.rowposition,"room_type_sid") = ds9.namevalue(ds9.rowposition,"room_type_sid");
							ds10.namevalue(ds10.rowposition,"room_sid") = ds9.namevalue(ds9.rowposition,"room_sid");
							ds1.namevalue(i,"use_yn") = 'F';						
						} else {	//�ߺ������� üũ
							for ( j=1; j<=ds10.CountRow; j++ ) {
								if ( ds1.namevalue(i,"rsv_sid") == ds10.namevalue(j,"rsv_sid") ) 
									exit='true';
							}
							if ( exit != 'true' ) {
								ds10.addrow();
								ds10.namevalue(ds10.rowposition,"accept_no") = ds1.namevalue(i,"accept_no");
								ds10.namevalue(ds10.rowposition,"cust_nm") = ds1.namevalue(i,"cust_nm");
								ds10.namevalue(ds10.rowposition,"sex_nm") = ds1.namevalue(i,"sex_nm");
								ds10.namevalue(ds10.rowposition,"join_cd") = ds1.namevalue(i,"join_cd");
								ds10.namevalue(ds10.rowposition,"rsv_sid") = ds1.namevalue(i,"rsv_sid");
								ds10.namevalue(ds10.rowposition,"m_rsv_sid") = ds1.namevalue(i,"m_rsv_sid");
								ds10.namevalue(ds10.rowposition,"room_type_sid") = ds9.namevalue(ds9.rowposition,"room_type_sid");
								ds10.namevalue(ds10.rowposition,"room_sid") = ds9.namevalue(ds9.rowposition,"room_sid");
								ds1.namevalue(i,"use_yn") = 'F';						
							}
						}
					}
				}
			}
			if ( move_div == 'L' ) {
				for ( i=ds10.CountRow; i>0; i-- ) {
					if ( ds10.namevalue(i,"use_yn") == 'T' ) {
						ds10.deleterow(i);				
					}
				}
			}			
		}
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
		
		<script language=JavaScript for= lc5 event=OnSelChange()>
			if ( div != 'init' ) {	//��
				div = 'init';					
				fnSelectDs7();		
			}
		</script>		

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if ( ds10_search != 'true' )
				alert("���ǿ� ���� ���� ������ ���� ��ȸ�� �ּ���.");
			else {											
				var exit='';			
				if ( ds10.CountRow < 1 ) {
					ds10.addrow();
					ds10.namevalue(ds10.rowposition,"accept_no") = ds1.namevalue(ds1.rowposition,"accept_no");
					ds10.namevalue(ds10.rowposition,"cust_nm") = ds1.namevalue(ds1.rowposition,"cust_nm");
					ds10.namevalue(ds10.rowposition,"sex_nm") = ds1.namevalue(ds1.rowposition,"sex_nm");
					ds10.namevalue(ds10.rowposition,"join_cd") = ds1.namevalue(ds1.rowposition,"join_cd");
					ds10.namevalue(ds10.rowposition,"rsv_sid") = ds1.namevalue(ds1.rowposition,"rsv_sid");
					ds10.namevalue(ds10.rowposition,"m_rsv_sid") = ds1.namevalue(ds1.rowposition,"m_rsv_sid");
					ds10.namevalue(ds10.rowposition,"room_type_sid") = ds9.namevalue(ds9.rowposition,"room_type_sid");
					ds10.namevalue(ds10.rowposition,"room_sid") = ds9.namevalue(ds9.rowposition,"room_sid");
					ds1.namevalue(i,"use_yn") = 'F';						
				} else {	//�ߺ������� üũ
					for ( j=1; j<=ds10.CountRow; j++ ) {
						if ( ds1.namevalue(ds1.rowposition,"rsv_sid") == ds10.namevalue(j,"rsv_sid") ) 
							exit='true';
					}
					if ( exit != 'true' ) {
						ds10.addrow();
						ds10.namevalue(ds10.rowposition,"accept_no") = ds1.namevalue(ds1.rowposition,"accept_no");
						ds10.namevalue(ds10.rowposition,"cust_nm") = ds1.namevalue(ds1.rowposition,"cust_nm");
						ds10.namevalue(ds10.rowposition,"sex_nm") = ds1.namevalue(ds1.rowposition,"sex_nm");
						ds10.namevalue(ds10.rowposition,"join_cd") = ds1.namevalue(ds1.rowposition,"join_cd");
						ds10.namevalue(ds10.rowposition,"rsv_sid") = ds1.namevalue(ds1.rowposition,"rsv_sid");
						ds10.namevalue(ds10.rowposition,"m_rsv_sid") = ds1.namevalue(ds1.rowposition,"m_rsv_sid");
						ds10.namevalue(ds10.rowposition,"room_type_sid") = ds9.namevalue(ds9.rowposition,"room_type_sid");
						ds10.namevalue(ds10.rowposition,"room_sid") = ds9.namevalue(ds9.rowposition,"room_sid");
						ds1.namevalue(i,"use_yn") = 'F';						
					}
				}
			}
		</script>
				
		<script language="javascript"  for=gr2 event=OnClick(row,colid)>
				fnSelectDs10();
		</script>	

		<script language=JavaScript for=gr3 event=OnCloseUp(row,colid)>
			for ( i=1; i<=ds10.CountRow; i++ ) {
				if ( ds10.namevalue(i,"join_cd") == '01' ) {
					for ( j=1; j<=ds10.CountRow; j++ )
						ds10.namevalue(j,"m_rsv_sid") = ds10.namevalue(i,"rsv_sid");
					break;
				}
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
		var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            
	        //�޽��� ó��
	        var msg='';
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 ) 
	          	alert(msg);           
	          	
			fnSelectDS1();
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
         div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        //�����޽��� ó��
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
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
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
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
         div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
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
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
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
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
		fnSelectDs3();	// ���� �Ϸ�� ���ð�, ��ǰ���� ��ȸ
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		fnSelectDs6(); // ���ð� �Ϸ�� �� ��ȸ
</script>

<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
		fnSelectDs7(); // �� �Ϸ�� �� ��ȸ
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';	//�� �Ϸ��
</script>

<script language=JavaScript  for=ds10 event="OnLoadCompleted(row)">
	ds10_search='true';	//ds10 ��ȸ �Ϸ��
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
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
	
<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� �κ� 
				: ����ڸ�, ������ڵ�
-----------------------------------------------------------------------------*/
%>
												<tr>
													<td align="right" colspan="5">
														<table border="0"  cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td align="right" height="30px">		
																	<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
																	<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
																	<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
													 			</td>
															</tr>	
														</table>
													</td>											
												</tr>
												<tr height="50px">
													<td align="left" width="845px" colspan="5">
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
													                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds4>
																					<param name=BindColumn      value="goods_sid">
							                                                        <param name=BindColVal      value="goods_sid">
																					<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
																					<param name=ListExprFormat  value="goods_nm^0^150"></object>
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
										            						<td align=left class="text" width="70">��û����ȣ</td>
											                                <td align=left bgcolor="#ffffff" valign="middle" colspan="5">&nbsp;																							
																				<input id="sAcceptNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
																			</td>	
											            				</tr>		
											            			</table>
																</td>
															</tr>															
														</table>	
													</td>											
												</tr>
												<tr height="10">
													<td colspan="5"></td>
												</tr>													
												<tr>
													<td width="525px" rowspan="2">
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="525px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� ���� - 
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:525px; height:370" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>								                                        
																		<param name="Format" 			value="
															               <C> name='����'       ID='use_yn'      width=28 align=center editlimit=1 editstyle=checkbox show=true</C>
															               <C> name='��'        ID='class'       BgColor=#fefec0 width=25 align=right editlimit=3 edit=none show=true</C>
															               <C> name='��'        ID='teams'       BgColor=#fefec0 width=25 align=right editlimit=3 edit=none show=true</C>
															               <C> name='����'      ID='cust_nm'     BgColor=#fefec0 width=55 align=left editlimit=30 edit=none show=true</C>
															               <C> name='����'       ID='sex_nm'      BgColor=#fefec0 width=28 align=center editlimit=50 edit=none show=true</C>
															               <C> name='�ֹι�ȣ'    ID='manage_no'   BgColor=#fefec0 width=90 align=center editlimit=20 edit=none show=true </C>
															               <C> name='����'   ID='join_cd_nm'  BgColor=#fefec0 width=45 align=left editlimit=50 edit=none show=true</C>
															               <C> name='����Ÿ��' ID='room_type_cd'        BgColor=#fefec0 width=55 align=center editlimit=10 edit=none show=true</C>															               
															               <C> name='���ǹ�ȣ'      ID='room_no'     BgColor=#fefec0 width=55 align=right editlimit=10 edit=none show=true</C>															               
															               <C> name='����'    ID='m_cust_nm'   BgColor=#fefec0 width=55 align=left editlimit=30 edit=none show=true</C>
															               <C> name='����'       ID='m_sex_nm'      BgColor=#fefec0 width=28 align=center editlimit=50 edit=none show=true</C>
															               <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
															               <C> name='�����Ϳ���SID'    ID='m_rsv_sid'   align=left editlimit=12 show=false</C>
															               <C> name='����Ÿ��SID' ID='room_type_sid'        BgColor=#fefec0 width=60 align=center editlimit=10 show=false</C>															               															               
															               <C> name='����SID'     ID='room_sid'    align=left editlimit=12 show=false</C>
															               <C> name='��û����ȣ'    ID='accept_no'   align=left editlimit=15 show=false</C>
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
															</tr>
														</table>
													</td>
													<td width=5>&nbsp;</td>
													<td style="width:10px;height:180px" align="center" valign="middle">                                                                                                                    
													</td>								
													<td width=5>&nbsp;</td>																		
													<td width="280px" height="100" valign=top>
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="280px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� ���� - 
	Object ID 	: �׸��� , gr2
	Data ID		: ds2
-----------------------------------------------------------------------------*/
%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:280px; height:180" border="1" >
								                            			<param name="DataID"		VALUE="ds9">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>								                                        
																		<param name="Format" 			value="
															              <C> name='���ǹ�ȣ'      ID='room_no'     BgColor=#fefec0 width=60 align=right editlimit=5 edit=none show=true</C>
															              <C> name='����Ÿ��' ID='room_type_cd'        BgColor=#fefec0 width=60 align=center editlimit=5 edit=none show=true</C>
															              <C> name='����'   ID='room_state'  BgColor=#fefec0 width=30 align=center editlimit=2 edit=none show=true</C>
															              <C> name='����SID'     ID='room_sid'    align=left editlimit=12 show=false</C>
															              <C> name='����Ÿ��SID'        ID='room_type_sid'       align=left editlimit=12 show=false</C>
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
															</tr>
														</table>
													</td>														
												</tr>	
												<tr>
													<td width=5>&nbsp;</td>												
													<td style="width:10px;height:180px" align="center" valign="middle">                                                                                                                    
													<img src="<%=dirPath%>/Sales/images/arrow_01.gif" style="cursor:hand" onclick="fnMove('R')"><br><br>                                                                            
													<img src="<%=dirPath%>/Sales/images/arrow_02.gif" style="cursor:hand" onclick="fnMove('L')"><br><br>                                                                             
													</td>		
													<td width=5>&nbsp;</td>
													<td width="280px" height="100" valign=top>
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="280px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� ���� - 
	Object ID 	: �׸��� , gr3
	Data ID		: ds3
-----------------------------------------------------------------------------*/
%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr3 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:280px; height:180" border="1" >
								                            			<param name="DataID"		VALUE="ds10">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>								                                        
																		<param name="Format" 			value="
															               <C> name='����'    ID='use_yn'   width=28 align=center editstyle=checkbox editlimit=15 show=true</C>																		
															               <C> name='��û����ȣ'    ID='accept_no'   BgColor=#fefec0 width=80 align=center editlimit=15 edit=none show=true</C>
															               <C> name='����'      ID='cust_nm'     BgColor=#fefec0 width=55 align=left editlimit=30 edit=none show=true</C>
															               <C> name='����'       ID='sex_nm'      BgColor=#fefec0 width=28 align=center editlimit=50 edit=none show=true</C>
															               <C> name='����'      ID='join_cd'     width=65 align=center editlimit=2 editstyle=lookup data='ds8:join_cd:join_cd_nm' show=true</C>
															               <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
															               <C> name='�����Ϳ���SID'    ID='m_rsv_sid'   align=left editlimit=12 show=false</C>
															               <C> name='����Ÿ��SID'        ID='room_type_sid'       align=left editlimit=12 show=false</C>
															               <C> name='����SID'     ID='room_sid'    align=left editlimit=12 show=false</C>
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
															</tr>
														</table>
													</td>													
												</tr>																							
<!--------------------------------- �ڵ� �κ� �� -------------------------------->		
										</td>
									</tr>
									
								</table>
							</td>
						</tr>
					</table>
<jsp:include page="/Sales/common/include/body_e.jsp"/>