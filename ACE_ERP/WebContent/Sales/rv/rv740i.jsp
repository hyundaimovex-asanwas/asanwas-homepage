<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��鵵
 * ���α׷�ID 	: Rv740i
 * J  S  P		: Rv740i
 * �� �� ��		: Rv740i
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-27
 * �������		: 
 * �� �� ��		:	�ɵ���
 * ��������		:   ���ǻ��º��� ��ũ��Ʈ �� ����/�ڵ����� 		��
 *				: 	�ڵ����� �� ���Ǽ������� ��ũ��Ʈ ���� 		��
 *				:  	���� �Ķ���� ������					��
 *				:   ���ǻ��� ��ȸ ���� �Ⱓ������ ����			��
 *				:   ���� ȣ���رݰ��� ��ũ��Ʈ �� ����		��
 *				:   �ڵ�����..							��
 *				:   ���� �ڵ����� ��ũ��Ʈ
 * ������������ 	: 20060915
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-02-20][�ɵ���] ���� ���� �˾� ����
 
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
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");		//���

			sSDate.Text = '<%=firstday%>';	
			sTDate.Text = '<%=firstday%>';	
			div = 'init';
			fnGoods();
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
				alert("���ڱⰣ �������� �Է����ּ���.");
				sSDate.focus();
				return false;
			};
			if(!sTDate.Text){
				alert("���ڱⰣ �������� �Է����ּ���.");
				sTDate.focus();
				return false;
			};
	
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sTDate.Text;			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);

			fnSelect3();
		}


		/*
		 * �����ο� ��ȸ 
		 */
		function fnSelect2() {
			var sAssign="";
				if (getObjectFirst("sAssign_YN").checked) {
					sAssign="Y";
				} else {
					sAssign="N";
				}		
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sAccept_no=" + getObjectFirst("sAccept_no").value
			          + ",sGoodSid=" + ds_goods.namevalue(ds_goods.rowposition,"goods_sid") 
			          + ",sClass=" + lc5.ValueOfIndex("class", lc5.Index)
			          + ",sTeam=" + lc6.ValueOfIndex("teams", lc6.Index)
			          + ",sAssign_YN=" + sAssign
			          + ",sJobsel=" + sJobsel.value;

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
		}
		
		/*
		 * ���� ��� ��ȸ (���)
		 */
		function fnSelect3() {
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sTDate.Text;			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS3=ds3)",
			    param);
			   
			tr_post(tr1);
		}
		
		
					

		//���� ���� ���� (�󰴽�, �켱����(�ڵ��������)����)
		function fnApply1() {
			if (ds1.IsUpdated) {
				v_job = "I1";	//��� ���ǻ��� ������ I1
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          + ",sUpjang="+ getObjectFirst("sUpjang").value
				          + ",sSDate=" + sSDate.Text
				          + ",sTDate=" + sTDate.Text;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
				    "JSP(I:DS1=ds1,O:RESULT=ds_result)",
				    param);
				   
				tr_post(tr1);  
				
				fnSelect();
			} else {
				alert("������ ������ �����ϴ�.");
			};
			
		}

		/*
		 * ���� �������� (��ǰ ������ ����)
		 */
		function fnApply2() {
			if (ds_goods.namevalue(ds_goods.rowposition,"goods_sid")=="0"){
				alert("�������� ���� �ݵ�� ��ǰ�� �������ּž� �մϴ�.");
				return;
			};
			 
            if (ds2.IsUpdated){		
	            v_job = "I2";	//���� ������ I2
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          + ",sUpjang="+ getObjectFirst("sUpjang").value
				          + ",sSDate=" + sSDate.Text
				          + ",sTDate=" + sTDate.Text
				          + ",sGoodSid=" + ds_goods.namevalue(ds_goods.rowposition,"goods_sid") 
				          + ",sClass=" + ds_class.namevalue(ds_class.rowposition,"class")
				          + ",sTeam=" + ds_team.namevalue(ds_class.rowposition,"teams") ;
				   //alert(param);
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
				    "JSP(I:DS2=ds2,O:RESULT=ds_result)",
				    param);
				   
				tr_post(tr1);
			} else {
				alert("������ ���� �����ϴ�.");
			};
		}	
		
		/*
		 * ���� �������� (���ڱⰣ ����)
		 */
		function fnApply4() {
            if (ds2.IsUpdated){		
	            v_job = "I2";	//���� ������ I2
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          + ",sUpjang="+ getObjectFirst("sUpjang").value
				          + ",sSDate=" + sSDate.Text
				          + ",sTDate=" + sTDate.Text
				          + ",sGoodSid=" + ds_goods.namevalue(ds_goods.rowposition,"goods_sid") 
				          + ",sClass=" + ds_class.namevalue(ds_class.rowposition,"class")
				          + ",sTeam=" + ds_team.namevalue(ds_class.rowposition,"teams") ;
				   //alert(param);
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
				    "JSP(I:DS4=ds2,O:RESULT=ds_result)",
				    param);
				   
				tr_post(tr1);
			} else {
				alert("������ ���� �����ϴ�.");
			};
		}	


		/*
		 * �ڵ�����
		 */
		function fnApply3() {
			if (ds1.IsUpdated) {
				alert("���°� ���� ���� ������ �ֽ��ϴ�. ���¸� ����(��ܿ���)�� �� �ڵ������� Ŭ���� �ּ���.");
				return;
			} else {
				if(sFromRoomType.Text.length <5){
					alert("����Ÿ���� 5�ڸ����� �մϴ�.");
					sFromRoomType.focus();
					return false;
				}
				if(sToRoomType.Text.length <5){
					alert("����Ÿ���� 5�ڸ����� �մϴ�.");
					sToRoomType.focus();
					return false;
				}				

				if(confirm("����Ÿ��["+sFromRoomType.Text+"]���� ����Ÿ��["+sToRoomType.Text+"]���� �ڵ������մϴ�.\n ���� �����Ͻðڽ��ϱ�?")) {
			
					var sAssign="";
						if (getObjectFirst("sAssign_YN").checked) {
							sAssign="Y";
						} else {
							sAssign="N";
						}
					v_job = "I2";	//���� ������ I2
					var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
					          + ",sSDate=" + sSDate.Text
					          + ",sAccept_no=" + getObjectFirst("sAccept_no").value
					          + ",sGoodSid=" + ds_goods.namevalue(ds_goods.rowposition,"goods_sid") 
					          + ",sUpjang="+ getObjectFirst("sUpjang").value				          				          
					          + ",sClass=" + ds_class.namevalue(ds_class.rowposition,"class")
					          + ",sTeam=" + ds_team.namevalue(ds_team.rowposition,"teams") 
					          + ",sAssign_YN="+ sAssign
					          + ",sFromRoomType=" + sFromRoomType.Text
					          + ",sToRoomType=" + sToRoomType.Text;

					// �ڵ������� ���� �����ͼ°� ������ ������ ��� ������ ���� �ִ� ds2�� ���´�.
					// ������ ���� ���� ds3�� ȣ���� ���, onfail �̺�Ʈ���� Not Found Client DataSet=[ds3]��� ������. 2006-12-5 �ɵ���
					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
					    "JSP(I:DS3=ds2,O:RESULT=ds_result)",
					    param);
					   
					tr_post(tr1);	

//			        fnSelect();   //���� ��ȸ (���)
//			        fnSelect2();   //��� ��ȸ					
					sFromRoomType.Text="";
					sToRoomType.Text="";
				}
			}
		}	
		
		
		/*
		 *	��� 
		 */
		function fnCancel() {
			ds2.undoall();
		} 
			
			
			
			
		// ��ǰ
		function fnGoods() {
			if (div == 'init') {
				ln_TRSetting(tr2, 
	           	 	"<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	           	 	"JSP(O:S_GOODS_DS=ds_goods)",
	            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value);
	       		 tr_post(tr2);
			} else  {
				ln_TRSetting(tr2, 
	           	 	"<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	           	 	"JSP(O:S_GOODS_DS=ds_goods)",
	            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sSDate.Text+",sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value);
	       		 tr_post(tr2);
			}
		}
		
		// ��
		function fnClass() {
			if (div == 'init') {
				ln_TRSetting(tr3, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS6=ds_class)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value +",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
		        tr_post(tr3);
		        
			} else {
				ln_TRSetting(tr3, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS6=ds_class)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sSDate.Text+",sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value +",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
	        	tr_post(tr3);
			}
			
		}
		
		// �� 	
		function fnTeam() {
			if (div == 'init') {
				ln_TRSetting(tr4, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS7=ds_team)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value 
		            		+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc5.ValueOfIndex("class", lc5.Index));
		        tr_post(tr4);
			} else {
				ln_TRSetting(tr4, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS7=ds_team)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sSDate.Text+",sSaupSid=1,sUpjang="+getObjectFirst("sUpjang").value
	            			+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc5.ValueOfIndex("class", lc5.Index));
	            			
	        	tr_post(tr4);
			}
			
			div='';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
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
				getObjectFirst("TR_108").style.display='none';
			}  if (sUpjang.value == '108') {	
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
				getObjectFirst("TR_71").style.display='none';
				getObjectFirst("TR_108").style.display='inline';
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
			    	
			    	//alert(status);
			    	
			    	if (status == "1" ) {
			    		alert ("�� �����Դϴ�!");
			    		return false;
			    	} else if(status == "2" || status == "3"){	
			    		alert ("�ڵ����� ���������Դϴ�!");
			    		return false;
			    	} else {
			    		fnStatusPop(roomSid, status, sSDate.Text, sTDate.Text);
			    	};
		    	};
		    } else {
		    	alert("������ �����ϴ�!");
		    };
   		};



	// ���� ���¹ٲٱ� ��ũ��Ʈ ---------------------------------------------------------------------------------------
		function statChange(obj) {	//���� 3(�켱), 1(���) �� ��������.
			// �� ȣ�� �� ������ ���ȣ ������ �����ؼ� �̸� idx�� ����� ����... �����ϴ� idx�� �� TD ID ���� �־� ����.
			// �׷� ��� ���� �ٲܶ�.... for roop �� ���� �ʾƵ� �ȴ�.
			var objid=obj.id;
			//alert(objid);			//==getObjectFirst(01-"+ds1.namevalue(i, "ROOM_NO2")
			var objVal = objid.split("-");
			if(!roomChk.checked){	//roomchk�� üũ�ȵǸ� �� ���������̶�� �ǹ�
				//�󰴽� or �������� or �̹̹������Ǹ� ���� ����
				// ��, �ѹ� ������ ���ǿ� �߰��� ������ �� ����.. 2006-12-5 �ɵ���+������
				if(ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")=="1"||ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")=="4"||ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")=="5"){
					for (i = 0 ; i <= ds2.countrow; i++) {	//DS2(������)���� ���������Ϸ��� �� ã��
						if (ds2.namevalue(i, "CHOICE")=="T") {
							ds2.namevalue(i, "ROOM_NO")=objVal[3];
							ds2.namevalue(i, "ROOM_TYPE_CD")=objVal[4];
							ds2.namevalue(i, "ROOM_SID")=objVal[5];
						};
					};
				} else {
					alert("���尴��, �ڵ�����, �̹��ڵ� ������  ������ �Ұ��մϴ�.");
				};
			} else {	//roomChk.checked
				if(ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")=="3"){	//�켱�����϶��� �󰴽Ƿ� ����
					ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")="1";
					ds1.namevalue(objVal[0], "ROOM_STATUS")="VC";
					obj.background='<%=dirPath%>/Sales/images/map/1_e.jpg';		//ȸ��															
				} else if(ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")=="1"){	//������϶��� �켱���� ����
					ds1.namevalue(objVal[0], "ROOM_STATUS_TXT")="3";
					ds1.namevalue(objVal[0], "ROOM_STATUS")="IV";
					obj.background='<%=dirPath%>/Sales/images/map/1_r.jpg';		//����
				} else {
					alert("�󰴽� �� �ڵ��������Ǹ� ���������մϴ�. ");
				};
			};
		}

	// �� ���Ƿ� �����ϱ�  ��ũ��Ʈ ---------------------------------------------------------------------------------------
		function eraseNO(){
			for (i = 0 ; i <= ds2.countrow; i++) {	//DS2(������)���� �󰴽� �����Ϸ��� �� ã��
				if (ds2.namevalue(i, "CHOICE")=="T") {
					ds2.namevalue(i, "ROOM_SID")=0;
				};
			};
		};

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
	




	
	<script language=JavaScript for=ds_goods event=OnLoadCompleted(rowcnt)> <!-- ��ǰ -->
		if (div == 'init') {
			fnClass();
		}
	</script>
	<script language=JavaScript for=ds_class event=OnLoadCompleted(rowcnt)> <!-- �� -->
		if (div == 'init') {
			fnTeam();
		}
	</script>
	
	<script language=JavaScript for=sSDate event=OnKillFocus()>
			if ( div != 'init' ) {	//������� ��Ŀ�� �̵� 
				if ( sSDate.Modified ) {
					fnGoods();			
				}
			}				
	</script>

	<script language=JavaScript for=lc3 event=OnSelChange()>
		if ( div != 'init' ) {	//��ǰ ����
			fnClass();
		}
	</script>	
	<script language=JavaScript for=lc5 event=OnSelChange()>
		if ( div != 'init') {	// �� ����
			fnTeam();
		}
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

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ǰ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_team classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �� -->
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
									<td>�� </td>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply1()"> 		<!-- ���� -->
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
								<option value="108">��2��Ȱ����(SL)</option>
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
							<%=HDConstant.COMMENT_END%>&nbsp;-
							<%=HDConstant.COMMENT_START%>
							<object id=sTDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
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
						<td width=60><input type=checkbox name=roomChk checked><B>�켱</B></td>
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
				<div id=pageSelect style='width:845;height:240;overflow-y:auto;background:white;border:1 solid 	#9D9C9C;display:;position:relative;top:3px'>
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
					<tr id=TR_108 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang108n.jsp"/>
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
 
						<td>				
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width=600 height=300 border=1 >
								<param name="DataID"        value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<Param Name="UsingOneClick"   value="1">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								   	<C> name='No.'          ID='{STRING(CURROW)}'   Width=30    align=center</C>
								   	<C> name='����'    		ID='CHOICE'  width=30 	align=center editlimit=16 show=true EditStyle=CheckBox</C>
									<C> name='��ǰ��'    		ID='GOODS_NM'  		 width=55 	align=left editlimit=15 edit=none show=true  </C>
									<C> name='��û����ȣ'    	ID='ACCEPT_NO'  		 	width=100 	align=center editlimit=15 edit=none show=true </C>
									<C> name='����'      	ID='CUST_NM'   		  	width=50 	align=left editlimit=30  edit=none show=true sort=true</C>
									<C> name='�ֹι�'    	ID='MANAGE_NO'  	 	width=45  	align=left editlimit=20  edit=none show=true </C>
									<C> name='��û����' 		ID='A_ROOM_TYPE_CD'     	width=55   	align=center editlimit=10  edit=none show=true  </C>
									<C> name='Ȯ������' 		ID='ROOM_TYPE_CD'     	width=55   	align=center editlimit=10  edit=none show=true  </C>
									<C> name='��' 		ID='ROOM_NO'     	width=45   	align=center editlimit=10  edit=TRUE show=true  sort=true</C>
									<C> name='������' 		ID='M_CUST_NM'     	width=55   	align=center editlimit=10  edit=none show=true  </C>
									<C> name='����' 			ID='DONGSUK'     	width=45   	align=center editlimit=10  edit=none show=true  </C>
									<C> name='��'        	ID='CLASS'       	width=25 	align=right editlimit=2 	show=true</C>
									<C> name='��'        	ID='TEAMS'      	width=25  	align=right editlimit=2 	show=true</C>
									<C> name='��ġ��'  	 	ID='HOLDER'  		width=50 	align=left editlimit=50  edit=none show=true  </C>
									<C> name='����'   		ID='COMPANY_NM'  	width=80 	align=left editlimit=30  edit=none show=true</C>
									<C> name='����'    		ID='POSITIONS'   	width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='��'    		ID='ROOM_SID'   	width=50 	align=left editlimit=30  edit=true show=true</C>									
									<C> name='rsv'    		ID='RSV_SID'   		width=50 	align=left editlimit=30  edit=none show=true</C>
								">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=right valign=top>
							<table  border=0 cellpadding='0' cellspacing='1' bgcolor=#666666>
								<tr>
									<td align=left class="text" >��ǰ����</td>
			                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
			                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_goods>
											<param name=BindColumn      value="goods_sid">
			                                <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^140"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								</tr>
								<tr>
									<td align=left class="text">��/��</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
			                            <object id=lc5 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_class>
											<param name=BindColumn      value="class">
			                                <param name=BindColVal      value="class">
											<param name=EditExprFormat	value="%,%;class,class_nm">
											<param name=ListExprFormat  value="class_nm^0^70"></object>
			                            <object id=lc6 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_team>
											<param name=BindColumn      value="teams">
			                                <param name=BindColVal      value="teams">
											<param name=EditExprFormat	value="%,%;teams,teams_nm">
											<param name=ListExprFormat  value="teams_nm^0^70"></object>
										<%=HDConstant.COMMENT_END%>
									</td>	
								</tr>
								<tr>
					              <td align=left class="text">������</td>
					              <td align="left" bgcolor="#ffffff">&nbsp;
			    					<select name="sJobsel"> 
				    					 <option value="0" SELECTED>��ü</option>
										 <option value="1">������</option>
										 <option value="2">�����</option>
										 <option value="3">���������</option>
									</select>
								  </td>
								</tr>
								<tr>
									<td align=left class="text">��û����ȣ</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
									<INPUT id=sAccept_no NAME=sAccept_no MAXLENGTH=14 SIZE=14 type="text" class='textbox'>
			                        </td>
								</tr>
								<tr>
									<td align=left class="text">�̹���</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<input type=checkbox name="sAssign_YN" id="sAssign_YN">������<img src="<%=dirPath%>/Sales/images/eraser.gif" style="cursor:hand"	align=absmiddle onclick="eraseNO()"></td>
								</tr>								
								<tr height=24>
			                        <td align=center bgcolor="#ffffff" colspan=3><img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect2()"> 		<!-- ��ȸ -->
											<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply2()"> 		<!-- ��ǰ�� �������� �������� ���� -->
											<img src="<%=dirPath%>/Sales/images/cancel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCancel()"> 		<!-- ��� --></td>
								</tr>
							</table>
							<BR>
							<table  border=0 cellpadding='0' cellspacing='1' bgcolor=#666666>
								<tr height=24>
									<td align=center class="text" rowspan=2><img src="<%=dirPath%>/Sales/images/auto_assign.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply3()"></td>
			                        <td width=146 align=center bgcolor="#ffffff">&nbsp;FromType �� ToType</td>
								</tr>
								<tr height=24>
			                        <td align=center bgcolor="#ffffff">&nbsp;
			                        <%=HDConstant.COMMENT_START%>
                                    <object id=sFromRoomType classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='17px' width='50px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="ZZZZZ">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                        <param name=UpperFlag   value=1>                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
			                        &nbsp;�� 
                        			<%=HDConstant.COMMENT_START%>
                                    <object id=sToRoomType classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='17px' width='50px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="ZZZZZ">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                        <param name=UpperFlag   value=1>                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
			                        </td>
								</tr>
							</table>
							<BR>
							<table  border=0 cellpadding='0' cellspacing='1' bgcolor=#666666 width=215>
								<tr height=24>
			                        <td align=center class="text">[���ڱⰣ]���� ����</td>
								</tr>
								<tr height=24>
			                        <td align=center bgcolor="#ffffff">
											<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply4()"> 		<!-- ��ȸ������ ���ڱⰣ �������� ���� --></td>
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

