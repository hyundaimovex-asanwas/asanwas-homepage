<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��鵵
 * ���α׷�ID 	: Rm120S
 * J  S  P		: rm120s
 * �� �� ��		: rm120s
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-27
 * �������	:
 * ��������	: 
 * [��  ��   ��  ��][������] ����
 *						2006-09-06 ���̾��� ��ũ��Ʈ �߰�
 *						2006-09-06 ����1 ���̾� ��
 *							������ ���� ���̾� ����
 *							���� Ÿ�� �߰�
 *							�̹��� ���� (���ϰ��Ǳ���)
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-02-16][�ɵ���] ��ü ȣ�ڿ� ���� ������Ȳ �� �߰�.
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
   	String firstday = m_today.format(date.getTime());	
//   	firstday="20060805";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
         var v_job = "H";		
		 var div='';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	        v_job = "H";		

			cfStyleGrid(getObjectFirst("gr3"), "comn");		//���׸���

			sSDate.Text = '<%=firstday%>';	
			div = 'init';
		} 
		 
		function fnInit() {
		}
		
		/*
		 * ���� ��ȸ (���)
		 */
		function fnSelect() {
			if(getObjectFirst("sUpjang").value=="0"){
				alert("�������� �ݵ�� �����ϼž� �մϴ�.");
				return false;
			}
			if(!sSDate.Text){
				alert("�������ڸ� �Է����ּ���.");
				sSDate.focus();
				return false;
			};
	
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sSDate.Text;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);

			fnSelect3();
		}


		/*
		 * ���� ��� ��ȸ (���)
		 */
		function fnSelect3() {
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sSDate.Text;			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS3=ds3)",
			    param);
			   
			tr_post(tr1);
		}
			
   		// ������ ����� ������ Ȱ��/��Ȱ�� 	
		function fnChange() {
			if (sUpjang.value == '1') {
				getObjectFirst("TR_1").style.display='inline';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';				
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			} if (sUpjang.value == '2') {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='inline';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '3' ) {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='inline';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '5') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='inline';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '6') {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='inline';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '7') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='inline';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '8' ) {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='inline';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '9') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='inline';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '10') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='inline';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';				
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '11') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='inline';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '13') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='inline';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '24') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='inline';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '12') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='inline';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '71') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='inline';
			} 			

		}
	
		
		

	// ���� ���� �˾� ��ũ��Ʈ ---------------------------------------------------------------------------------------		
		function fnStatusPop(roomsid, status,sBgnDate,sEndDate) {
		/*	���´� ������ �Ͱ� ���尴�� 2����.
			ROOM_STATUS_TXT") == '1') {	 //���
			ROOM_STATUS_TXT") == '2') {	 //�̹��ڵ�
			ROOM_STATUS_TXT") == '3') {	 //�ڵ����� (�켱����)
			ROOM_STATUS_TXT") == '4') {	 //�̹̹���
			ROOM_STATUS_TXT") == '5') {	 //��������
			ROOM_STATUS_TXT") == '6') {	 //���尴��      */

	        var arrParam    = new Array();
	        var arrResult   = new Array();
	       
	        var param = "?sRoomSid=" + roomsid
			          + "&sRoomStatus=" + status
        			  + "&sBgnDate=" + sBgnDate
					  + "&sEndDate="+ sEndDate;
			if (status == "4") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "5") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "6") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "undefined" || status == null) {
				alert("������ ��ġ���� �ʽ��ϴ�!");
				return;
			}          

			var win = document.all.roomInfoWin;
			win.src = "";
			win.style.display = "none";
			win.src = strURL;
			win.style.display = "";			
		};		
		
		//��Ŭ��
		function fnRClick(obj) {
			 if (ds1.countrow > 0 ) {	
			 	var status;
			 	var roomSid;
			    if (event.button==2 || event.button==3) {
			    	for (i = 1; i <= ds1.countrow; i++) {
			    		if(obj.id == ds1.namevalue(i, "ROOM_NO2")) {
			    			status = ds1.namevalue(i, "ROOM_STATUS_TXT"); //1:���,4:������,5:�̹̹�����, 6:�����
			    			roomSid = ds1.namevalue(i, "ROOM_SID");
			    		};
			    	};
			    	
			    	if (status == "1" ) {
			    		alert ("�� �����Դϴ�!");
			    		return false;
			    	} else if(status == "2" || status == "3"){	
			    		alert ("�ڵ����� ���������Դϴ�!");
			    		return false;
			    	} else {
			    		fnStatusPop(roomSid, status, sSDate.Text, sSDate.Text);
			    	};
		    	};
		    } else {
		    	alert("������ �����ϴ�!");
		    };
   		};



		// ��Ŭ��=��Ŭ���� ����
		function statChange(obj) {
			 if (ds1.countrow > 0 ) {	
			 	var status;
			 	var roomSid;
			    	for (i = 1; i <= ds1.countrow; i++) {
			    		if(obj.id == ds1.namevalue(i, "ROOM_NO2")) {
			    			status = ds1.namevalue(i, "ROOM_STATUS_TXT"); //1:���,4:������,5:�̹̹�����, 6:�����
			    			roomSid = ds1.namevalue(i, "ROOM_SID");
			    		};
			    	};
			    	
			    	if (status == "1" ) {
			    		alert ("�� �����Դϴ�!");
			    		return false;
			    	} else if(status == "2" || status == "3"){	
			    		alert ("�ڵ����� ���������Դϴ�!");
			    		return false;
			    	} else {
			    		fnStatusPop(roomSid, status, sSDate.Text, sSDate.Text);
			    	};
		    } else {
		    	alert("������ �����ϴ�!");
		    };
		}


	// ���ǥ ����� ��� ��ũ��Ʈ ---------------------------------------------------------------------------------------
		function togLayer(){
			if(getObjectFirst("summaryTb").style.display=='none'){
				getObjectFirst("summaryTb").style.display='';
			} else {
				getObjectFirst("summaryTb").style.display='none';
			};
		}
	
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
//		���� �ʿ��� �޼��� ����� rm310i.jsp ��ĳ���� ������ ������ ��..
		var msg='';
        if(v_job=="I1") {	//���� ���� ����
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//            for ( i=1; i<=msgDS.CountRow; i++ )
//            	msg+=msgDS.namevalue(i,"pMsg")+"\n";
//            if ( msgDS.CountRow > 0 ) 
//	          	alert(msg);     
	        fnSelect();   //���� ��ȸ (���)
        }  else if(v_job == "I2") {	// ���� ����
	        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
	        fnSelect();   //���� ��ȸ (���)
	        fnSelect2();   //��� ��ȸ
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        };
	</script>
	<script language=JavaScript for="tr1" event=OnFail()>
		alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
/*        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		div='';  
		
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        var msg='';
        //�޽��� ó��
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		*/
	</script>
	

	<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
	    if(row==0) return;
	    var v_yn = "";
	    var v_msg = "";
	    for(var i=1; i<=row; i++){
	        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
	            v_msg += ds_result.NameValue(i, "MSG")+"\n";
	        }
	    }
	    if(v_msg!=""){
	        alert(v_msg);
	    }
	</script>


	<script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>
		var upjang = sUpjang.value;
		
		for (i = 1 ; i <= ds1.countrow; i++) {
			if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '4') {	 //�̹̹���
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_f.jpg';		//��Ȳ
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '5') {	 //���� �� ���ǹ����Ϸ�
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_m.jpg';	//�ϴ�
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '3') {	 //�켱����
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_r.jpg';	 //����
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '6') {	 //�������
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_p.jpg';	//��ȫ
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '1') {	 //���
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_e.jpg';	//ȸ��
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '2') {	 //�ٸ� �� �ڵ�����
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_b.jpg';	//��û
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");					
				}
			}
		}
	</script>
	
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
	</script>

<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��� ���ǻ���  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������ο�����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���ǻ��� ���ǥ  -->
	<param name="SyncLoad" 	value="true">
</object>


<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>

<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ǰ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	
<!-- ���ǻ���â ���̾� -->
<iframe id=roomInfoWin frameborder=0 marginwidth=0 marginheight=0 scrolling=no style="POSITION: absolute;DISPLAY:none;width:520;height:260;left: expression((document.body.clientWidth - 520)/2);top: expression((document.body.clientHeight - 260)/2);Z-INDEX: 9;"></iframe>

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845' >
					<tr>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
									<td> </td>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr height="5px">
			<td></td>
		</tr>
		
		<tr height="30px">
			<td width='845px' colspan=2>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="60px">ȣ����</td>
	                    <td align=left width=530 bgcolor="#ffffff">&nbsp;																										
							<select name="sUpjang" onchange="javascript:fnChange()">
								<option value="0">ȣ���� �����ϼ���!</option>
								<option value="1">�ݰ���ȣ�� ����(GH)</option>
								<option value="2">�ݰ���ȣ�� ����(GB)</option>
								<option value="3">�йи���ġȣ��(FH)</option>
								<option value="5">�ܱݰ�ȣ��(MH)</option>
								<option value="6">�رݰ�ȣ��(HH)</option>
								<option value="7">�ݰ����Ÿ��(PT)</option>
								<option value="8">��õ������(OV)</option>
								<option value="9">���渶��(NV)</option>
								<option value="10">������Ʈ��(FD)</option>
								<option value="11">ķ��ī(CC)</option>
								<option value="24">�غ���Ʈ(ST)</option>
								<option value="12">�ڰ���Ʈ(YT)</option>
								<option value="71">�ƻ��Ȱ��(AL)</option>
								<option value="13">�ݰ�������(KV)</option>

							</select>
						</td>	
						
						<td align=left class="text"  width=60>���ڱⰣ</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>

					</tr>
				</table>
			</td>
		</tr>
		
		
		<tr height='10px'>
			<td></td>
		</tr>
		
		<tr>
			<td align="right">
				<table>
					<tr align=center>
						<td width=60><a href="javascript:togLayer();">[���ǥ]</a></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_e.jpg"><FONT COLOR=white>�� ����</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_r.jpg"><FONT COLOR=white>�ڵ�����</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_m.jpg"><FONT COLOR=white>��������</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_b.jpg"><FONT COLOR=white>�̹��ڵ�</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_f.jpg"><FONT COLOR=white>�̹̹���</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_p.jpg"><FONT COLOR=white>���尴��</FONT></td>
					</tr>
				</table>
			</td>
		</tr>

		<tr id=summaryTb style="display:none"><!-- ���ǻ��� ���ǥ.-->
			<td align="right">
				<%=HDConstant.COMMENT_START%>
				<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width=556 height=160 border=1 style="display:;">
					<param name="DataID"        value="ds3">
					<param name="ColSizing"		value="true">
					<param name="Fillarea"		value="false">
					<param name="Editable"		value="true">
					<param name="BorderStyle"	value="0">
					<param name=SortView  		value="Left">
					<param name=IndWidth 		value="20">
					<param name=ViewHeader      value="false">
				    <param name=ViewSummary     value=1>					
					<param name="Format" 			value="
					    <C> name='TYPE'       ID='TYPE'   Width=52    align=center SumText='��'</C>
					    <C> name='stat1'      ID='S1'  width=84     align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat2'   	  ID='S3'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat3'      ID='S5'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat4'      ID='S2'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat5'      ID='S4'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat6'      ID='S6'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
					">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
		
		<tr>
			<td align=center>
				<!-- ������ div -->
				<div id=pageSelect style='width:845;height:400;overflow-y:auto;background:white;border:1 solid 	#9D9C9C;display:;position:relative;top:3px'>
				<table  border='0' cellpadding='0' cellspacing='1'>
					<tr id=TR_1 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang01n.jsp"/>
						</td>
					</tr>

					<tr id=TR_2 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang02n.jsp"/>
						</td>
					</tr>

					<tr id=TR_3 style="display:none">
						<td>
								<jsp:include page="/Sales/rm/upjang03n.jsp"/>
						</td>
					</tr>
					
					<tr id=TR_5 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang05n.jsp"/>
						</td>
					</tr>

					<tr id=TR_6 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang06n.jsp"/>
						</td> 
					</tr>

					<tr id=TR_7 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang07n.jsp"/>
						</td>
					</tr>

					<tr id=TR_8 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang08n.jsp"/>
						</td>
					</tr>

					<tr id=TR_9 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang09n.jsp"/>
						</td>
					</tr>

					<tr id=TR_10 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang10n.jsp"/>
						</td>
					</tr>
					<tr id=TR_11 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang11n.jsp"/>
						</td>
					</tr>
					<tr id=TR_13 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang13n.jsp"/>
						</td>
					</tr>
					<tr id=TR_24 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang24n.jsp"/>
						</td>
					</tr>
					<tr id=TR_12 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang12n.jsp"/>
						</td>
					</tr>
					<tr id=TR_71 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang71n.jsp"/>
						</td>
					</tr>
				</table>
				</div>
			</td>
		</tr>

		<tr>
			<td><BR>
				<table border=0 width=845 cellspacing=0 cellpadding=0>
					<tr>
						<td>				
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=300 height=200 border=1 style="display:none;">
								<param name="DataID"        value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								   <C> name='No.'      	ID='{STRING(CURROW)}'   Width=30    align=center</C>
								   <C> name='room1'    	ID='ROOM_NO'  width=40 	align=left editlimit=16 show=true</C>
									<C> name='room2'   	ID='ROOM_NO2' width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='TYPE'    	ID='ROOM_TYPE_CD'  		 	width=50 	align=left editlimit=15 edit=none show=true  </C>
									<C> name='RoomSid'  ID='ROOM_SID'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='txt'      ID='ROOM_STATUS_TXT'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='st'       ID='ROOM_STATUS'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='RsvSid'   ID='RSV_SID'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>																		
								">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				<table>

			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

