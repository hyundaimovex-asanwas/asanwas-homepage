<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		:	��ǰ��� 
 * ���α׷�ID 	:	RM410I (�ڵ�� �빮��)
 * J  S  P		:	rm410i (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		:	Rm410i
 * �� �� ��		:	���ؼ�
 * �� �� ��		:	2006-06-08
 * �������		:	��ǰ��� ��ȸ, ����, ��� 
 * ��������		:   ��ǰ �Ӽ� �߰� : �׸��ڵ�
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-05-12][�ڰ汹] sales.trm200���̺��� display_seq�� grid��(����) ǥ�� �� ����/���尡�� �ϵ��� ����.
 * [2009-05-13][�ڰ汹] �˻����ǿ� [�������]�߰� & grid�� ���� �÷����� sort ��� �߰�.
 * [2009-11-24][�ڰ汹] �˻����ǿ� [����]�߰� 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
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
					
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit(); 
		}
		/*
		 * ����Ÿ�� ��� ����
		 */
		function fnSetHeaderDsInit(){
			if (ds1.countrow < 1){
				var s_temp1 = "goods_sid:INT,goods_cd:STRING,goods_nm:STRING,eng_nm:STRING,short_nm:STRING,course:STRING,nights:INT,days:INT,saup_sid:INT,use_yn:STRING,theme_cd:STRING";
				ds1.SetDataHeader(s_temp1);
			}		
		}	
		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
	        cfStyleGrid(getObjectFirst("gr1"), "comn");										
	        fnSetHeaderDsInit();	

			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //�����ڵ�
			
			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm040S",
	            "JSP(O:DS4=ds5)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
		    tr_post(tr1); 		
	
	        //��ǰ����
	        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds3.Reset();       				
	        
	        //�����ڵ�: �׸��ڵ� ����
	        ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM018&s_Item1=Y";
	        ds4.Reset();       					        
		}
		
		/*
		 * ���� ��ȸ.
		 */
		function fnSelect() {
			fnSelectDs1();
		}
		/*
		 * �����ͼ� ù��° ��ȸ
		 */
		function fnSelectDs1() {
			sUseYn = lc3.ValueOfIndex("detail", lc3.Index);		
			if (ds1.IsUpdated ) {
				alert("�������� ���� �ֽ��ϴ�!");
			} else {
				ds1.ClearAll();
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm410I?dsType=1&proType=S&sGoodsSid="+sGoodsSid.value+"&sGoodsCd="+sGoodsCd.value
																  +"&sUseYn="+lc3.ValueOfIndex("detail", lc3.Index)    +"&sSaupSid="+lc1.ValueOfIndex("saup_sid", lc1.Index) 
																  +"&sGoodsNm="+sGoodsNm.value;
				ds1.Reset();
			}		
		}
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
			ds1.addrow();
		}
		/*
		 * �����, ����
		 */
		function fnDeleteRowDs1() {
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * ����
		 */
		function fnApply() {
			var row1=ds1.countrow;
			if (ds1.IsUpdated) {
				for ( i=1; i<=ds1.countrow; i++ ) {
					if ( ds1.namevalue(i,"goods_cd") == '' ) { alert("��ǰ�ڵ�� �ʼ� �Է� �����Դϴ�."); return; }
					if ( ds1.namevalue(i,"goods_nm") == '' ) { alert("��ǰ���� �ʼ� �Է� �����Դϴ�."); return; }					
					if ( ds1.namevalue(i,"saup_sid") == '' ) { alert("�������� �ʼ� �Է� �����Դϴ�."); return; }					
				}
		         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";				
				tr1.KeyValue = "Rm410I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm410I?proType=A&dsNum=1";
				tr1.post();
			}
		}
					
		/*
		 * ��� 
		 */
		function fnCancel(){
				ds1.undoall();
				window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";											
		}	
		/*
		 *  �˾� 
		 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
		function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sGoodsSid.value = arrParam[0];
				sGoodsCd.value = arrParam[1];
				sGoodsNm.value = arrParam[2];					
			} else {
		    	sGoodsSid.value = '';
				sGoodsCd.value = '';
				sGoodsNm.value = '';					
			}
		} 	
		/*
		 * ��ǰ���� �ڵ�����(����)
		 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		function fnSetting(dataSet) {   
			var exit=false;
			if ( dataSet == 'ds3' ) {	//��ǰ����
				for ( i=1; i<=ds3.CountRow; i++ ) {
					if ( ds3.namevalue(i,"goods_cd") == sGoodsCd.value ) {
						sGoodsSid.value = ds3.namevalue(i,"goods_sid");
						sGoodsNm.value = ds3.namevalue(i,"goods_nm");
						exit=true;
						return;
					}
				}
				if ( exit != true ) {
					sGoodsSid.value = '';
					sGoodsNm.value = '';				
				}
			}		
		} 						
	
    </script>		 
			
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>

		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";			
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";			
		</script>
				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>

		<script language=JavaScript  for=ds4 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";			
		</script>
		
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='use_yn' ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }		
		</script>
	
		<script language=JavaScript for=ds1 event=OnDataError(row,colid)>
	         window.status="��ȿ���� ���� ���� �ԷµǾ����ϴ�. �ٽ� �Է����ּ���.";				
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
     	window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);          
	</script>	
		
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
		<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<!--  ��ǰ���� -->
		<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<!--  �����ڵ� : ��ǰ������ �׸� -->
		<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=display_seq classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<comment id="__NSID__"><object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
			<param name="KeyName"  value="toinb_dataid4">
		</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
		<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="0px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="10px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs1()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs1()" >																						
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">																				
												<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">																				
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="0px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
									<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
										<tr  bgcolor="#6f7f8d" height="10px" >
			            					<td align=left width=70 class="text">&nbsp; �� ��</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left width=70 class="text">&nbsp;��ǰ�ڵ�</td>
			                                <td align=left bgcolor="#ffffff" colspan=7 width="300">&nbsp;																										
												<input id="sGoodsSid" type="hidden">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:60px; height:20px;" maxlength=7 onBlur="fnSetting('ds3')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��ǰ������ �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" readOnly>																						
											</td>
											<td align=left width=70 class="text">&nbsp;�������</td>                                                                                                                                                                                                                                                                                                                                         
			                                <td align=left width=205 bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>                                                                                                                                                                                                   
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>                                                                                                                                          
													<param name=ComboDataID		value=ds5>                                                                                                                                                                      
													<param name=BindColumn      value="head">                                                                                                                                                              
                                                    <param name=BindColVal      value="head">                                                                                                                                                                                                                      
													<param name=EditExprFormat	value="%,%;head,detail_nm">                                                                                                                                         
													<param name=ListExprFormat  value="detail_nm^0^120">
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
				<tr height="10">
					<td></td>
				</tr>		
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="400px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
							                <C> name='��ǰSID'    ID='goods_sid'  HeadAlign=Center Width=100  align=left   editlimit=12 show=false</C>
							                <C> name='��ǰ�ڵ�'   ID='goods_cd'   HeadAlign=Center Width=50   align=center editlimit=7  show=true</C>
							                <C> name='��ǰ��'     ID='goods_nm'   HeadAlign=Center Width=100  align=left   editlimit=40 show=true</C>
							                <C> name='������'     ID='eng_nm'     HeadAlign=Center Width=60   align=left   editlimit=40 show=true</C>
							                <C> name='�����'     ID='short_nm'   HeadAlign=Center Width=60   align=left   editlimit=40 show=true</C>															                															                
							                <C> name='���'       ID='course'     HeadAlign=Center Width=250  align=left   editlimit=100show=true</C>
							                <C> name='�ڼ�'       ID='nights'     HeadAlign=Center Width=30   align=right  editlimit=5  show=true</C>
							                <C> name='�ϼ�'       ID='days'       HeadAlign=Center Width=30   align=right  editlimit=5  show=true</C>
							                <C> name='����'       ID='saup_sid'   HeadAlign=Center Width=70   align=center editlimit=5  editstyle=lookup data='ds2:saup_sid:saup_nm' show=true </C>
							                <C> name='�׸�'       ID='theme_cd'   HeadAlign=Center Width=70   align=center editlimit=5  editstyle=lookup data='ds4:detail:detail_nm' show=true </C>
							                <C> name='����'      ID='use_yn'     HeadAlign=Center Width=35   align=center editstyle=checkbox editlimit=1 show=true</C>
							                <C> name='DATA���翩��' ID='data_yn'  HeadAlign=Center Width=40   align=center editlimit=1  show=false</C>
							                <C> name='����' 		ID='display_seq'  HeadAlign=Center Width=50  align=center editlimit=10 show=true Sort=True</C>
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

