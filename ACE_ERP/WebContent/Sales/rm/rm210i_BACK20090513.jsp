<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		:	ȣ�ں� ������� 
 * ���α׷�ID 	:	RM210I (�ڵ�� �빮��)
 * J  S  P		:	rm210i (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		:	Rm210i
 * �� �� ��		:	���ؼ�
 * �� �� ��		:	2006-06-05
 * �������		:	ȣ�ں� ������� ��ȸ, ����, ��� 
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-04-08][�ɵ���] �д� ���� �߰��ؾ���..
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
   java.util.Date mydate = new java.util.Date();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyy");
   String today = m_today.format(mydate);	

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
			var div='';
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
				var s_temp1 = "head:STRING,detail:STRING,detail_nm:STRING";
				ds.SetDataHeader(s_temp1);
			}
							
		}	
		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			bgn_date.text='<%=today%>0101';
			end_date.text='<%=today%>1231';			
	        cfStyleGrid(getObjectFirst("gr1"), "comn");								
			div='init';
			fnSelectDs2();
			fnSelectDs4();			
		}
		/*
		 * ���� ��Ⱥ
		 */
		function fnSelect() {
			fnSelectDs1();
		}
		/*
		 * �����ͼ� ù��° ��ȸ
		 */
		function fnSelectDs1() {
			if (ds1.IsUpdated ) {
				alert("�������� ���� �ֽ��ϴ�!");
			} else {
				if ( bgn_date.text == '' || end_date.text == '' ) { alert("�������ڸ� �Է����ּ���."); return; }
				ds1.ClearAll();
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=1&proType=S&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&sUpjangSid="+ds3.namevalue(ds3.RowPosition, "upjang_sid")+"&sBgnUseDate="+bgn_date.text+"&sEndUseDate="+end_date.text;
				ds1.Reset();
			}		
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� ��ȸ
// Parameter 	: 
%>
		function fnSelectDs2() {
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //�����ڵ�			
		}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ ��ȸ
// Parameter 	: 
%>
			function fnSelectDs3() {
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=2&proType=INIT&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
				ds3.Reset();
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� ��ȸ
// Parameter 	: 
%>
			function fnSelectDs4() {
				ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?dsType=3&proType=INIT&sHead=RM006";
				ds4.Reset(); //����				
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
		function fnDeleteRow() {
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * ����
		 */
		function fnApply() {
			var row1=ds1.countrow;
			if (ds1.IsUpdated) {
		         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";			
				tr1.KeyValue = "Rm210I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm210I?proType=A&dsNum=1";
				tr1.post();
			}		
		}
		/*
		 * ��� 
		 */
		function fnCancel(){
			if(ds1.IsUpdated ) {
				ds1.undoall();
				window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";							
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
		<script language=JavaScript  for=ds3 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>				
		<script language=JavaScript  for=ds4 event="OnLoadStarted()" >
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>		
				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
		
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			div='';	
			fnSelectDs3(); 
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ds3.insertRow(1);
			ds3.namevalue(1,"upjang_nm") = "��ü";
			lc2.index = 0;		
					
	        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>	
		
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
			if(colid=="season_cd") {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				//arrParam[0] : head
				//arrParam[1] : detail
				//arrParam[2] : detail_nm
				//arrParam[3] : item1				
				arrParam[0] = "RM006";
				arrParam[1] = "�����ڵ�"; //�����ڵ��� �����Ͱ�
				strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != undefined) {
					arrParam = arrResult.split(";");
					gr1.SetColumn("season_nm"); 										
		    		ds1.namevalue(ds1.rowposition,"season_cd")=arrParam[1];
					ds1.namevalue(ds1.rowposition,"season_nm")=arrParam[2];
				} else {

				}
			}
		</script>	
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs3();
		</script>					

		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='season_cd' ) {
		   	for(i=1;i<=ds1.CountRow;i++){
		     	ds1.namevalue(i,colid) = ds1.namevalue(1, colid);
		     	ds1.namevalue(i,"season_nm") = ds1.namevalue(1, "season_nm");		     	
		    }
		   }
		</script>
		
		<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
	        var flag = false;
	        if(colid=="season_cd"){
	            for(var i=1; i<=ds4.CountRow; i++){
	                if(ds4.NameValue(i, "detail")==ds1.NameValue(row, colid)){
	                    ds1.NameValue(row, "season_nm") = ds4.NameValue(i, "detail_nm");
	                    flag = true;
	                    return;
	                }
	            }
	            if(!flag)
	                ds1.NameValue(row, "season_nm") = "";
	        }		
		</script>		
		
	    <script language=JavaScript for=bgn_date event=OnKillFocus()>
	        if( bgn_date.Modified == true )
				end_date.text = bgn_date.text;
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
	</script>
			
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<comment id="__NSID__">
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__">
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

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
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
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
						</table>	
					</td>											
				</tr>
				
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
									<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
										<tr  bgcolor="#6f7f8d" height="30px" >
											<td width="70px" class="text"> ���� </td>
											<td bgcolor="#ffffff">
												<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
													<tr>
														<td width="150px" align="center"  bgcolor="#FFFFFF">
													        <comment id="__NSID__"><object id=lc1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120>
																	<param name=ComboDataID		value=ds2>
																	<param name=EditExprFormat	value="%,%;saup_nm,saup_sid">
																	<param name=ListExprFormat  value="saup_nm^0^120">
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT> 		
														</td>	
													</tr>
												</table>
											</td>
											<td width="70px" class="text"> ������ </td>
											<td bgcolor="#ffffff">
												<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
													<tr>
														<td width="150px" align="center"  bgcolor="#FFFFFF">
													        <comment id="__NSID__"><object id=lc2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120>
																	<param name=ComboDataID		value=ds3>
																	<param name=EditExprFormat	value="%;upjang_nm">
																	<param name=ListExprFormat  value="upjang_nm^0^120">
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT> 		
														</td>	
													</tr>
												</table>
											</td>		
											<td width="70px" class="boardt02">��������</td>
											<td bgcolor="#ffffff" width="350px" colspan="3" align=left>
												<table width="100%" border="0" cellpadding="0" cellspacing="0" align="left" bgcolor="#ffffff">
													<tr>
														<td width="100px" align="left"  bgcolor="#FFFFFF">&nbsp;
															<comment id="__NSID__"><object id=bgn_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">	
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																						
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-		
														</td>	
														<td width="100px" align="left"  bgcolor="#FFFFFF">	
															<comment id="__NSID__"><object id=end_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=left class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">	
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																						
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														</td>																							
													</tr>
												</table>
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
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:380" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name=ColSelect       value="true">								                            			
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name="Format" 			value="
											<C> name='���SID' 		ID='saup_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
											<C> name='������SID' 		ID='upjang_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																							
											<C> name='�������' 		ID='upjang_nm' 				 	HeadAlign=Center Width=100  align=left editlimit=50 BgColor=#fefec0 edit=none</C>																					
											<C> name='��������' 		ID='use_date' 				 	HeadAlign=Center Width=80  align=center editlimit=8 BgColor=#fefec0 edit=none mask='XXXX-XX-XX'</C>																					
											<C> name='����' 		ID='day_nm' 				 	HeadAlign=Center Width=50  align=left editlimit=3 BgColor=#fefec0 edit=none</C>																																																											
											<C> name='���� ��'  		ID='season_cd'   	HeadAlign=Center Width=50 align=center editlimit=2 editstyle=popup HeadCheckShow=true</C>																														
											<C> name='�����' 	ID='season_nm' 				 	HeadAlign=Center Width=100  align=left BgColor=#fefec0 edit=none editlimit=50</C>
											
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
								<td width="25px">
								</td>					
							</tr>
						</table>
					</td>
				</tr>											

		</td>
	</tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

