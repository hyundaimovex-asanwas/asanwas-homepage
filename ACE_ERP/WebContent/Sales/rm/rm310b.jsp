<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ���ɽ��� ����
 * ���α׷�ID 	: RM310B (�ڵ�� �빮��)
 * J  S  P		: rm310b (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Rm310b
 * �� �� ��		: ���ؼ�
 * �� �� ��		: 2006-06-01
 * �������		: ���ɽ��� ����,��ȸ,����,��� 
* 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
			var div='';
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����ȸ
// Parameter 	: 
%>
			function fnInit(){ 
		        cfStyleGrid(getObjectFirst("gr1"), "comn");			
				div='init';
				fnSelectDs2();
			}
			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
				var s_temp = "atclscd:STRING,atclsnm:STRING,desc:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [��ȸ]
%>
			function fnSelect() {
				fnSelectDs1();
			}
									
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �а��ڵ� ��ȸ
// Parameter 	: 
%>
			function fnSelectDs1() {
				if (ds1.IsUpdated ) {
					alert("�������� ���� �ֽ��ϴ�!");
				} else {
					//alert(ds2.namevalue(ds2.RowPosition, "saup_sid"));
					//alert(ds3.namevalue(ds3.RowPosition, "upjang_sid"));
					ds1.ClearAll();
					ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?dsType=1&proType=S&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&sUpjangSid="+ds3.namevalue(ds3.RowPosition, "upjang_sid");
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
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?dsType=2&proType=INIT&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
				ds3.Reset();
			}			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [���� ]
%>

			function fnApply() {
				fnApplyDs1();
			}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [���� ] 
// 					: ������  
%>
			function fnApplyDs1() {
				var checkDiv='';			
				if(ds1.IsUpdated) {
					for( i=1;i<=ds1.CountRow;i++ ) {
						if ( ds1.namevalue(i,"use_yn") == 'T' ) {
							checkDiv='true';
							break;
						}
					}		
					if ( checkDiv != 'true' ) { alert("��� �ϳ��� ����üũ�� �����ϼž� �մϴ�."); return; } 				
			         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";							
					tr1.KeyValue = "Rm210I(I:INPUT_DATA=ds1)";
					tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310B?proType=A&dsNum=1&sSaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid");
					tr1.post();
				}
			}		
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
		function fnCancel(){
			if(ds1.IsUpdated ) {
				ds1.undoall();
			}
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";							
			return;
		}
						
		</script>
		
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>		
<%
////////////////////////////////////////////////////////////////////////////////
//// ���ɽ��� ������ ��ȸ�Ѵ� 
%>	
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			if ( colid == 'use_yn' ) {
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("�������ڿ� �������ڸ� �Է��ϼž� �մϴ�.");
				}
			}
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if ( colid == 'use_yn' ) {		
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("�������ڿ� �������ڸ� �Է��ϼž� �մϴ�.");
				}				
			}
		</script>
		
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs3();
		</script>		
		
<%
////////////////////////////////////////////////////////////////////////////////
//// ���ɽ��� ���� ��ȸ
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
		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			div='';	
			fnSelectDs3(); 
		</script>
		
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			ds3.insertRow(1);
			ds3.namevalue(1,"upjang_nm") = "��ü";
			lc2.index = 0;		
					
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		</script>		
		
		<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
			if ( colid == 'end_date' ) 	//�������ڿ� ���������� ���� üũ
				if ( ds1.namevalue(row,"bgn_date") != '' ) {			
					if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
						alert("�������ڰ� �������ں��� �۽��ϴ�. �ٽ� �Է��� �ּ���.");
						ds1.namevalue(row,"end_date") = '';
					}
				}
			if ( colid == 'bgn_date' ) 	//�������ڿ� ���������� ���� üũ
				if ( ds1.namevalue(row,"end_date") != '' ) {
					if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
						alert("�������ڰ� �������ں��� �۽��ϴ�. �ٽ� �Է��� �ּ���.");
						ds1.namevalue(row,"bgn_date") = '';
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
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>			
<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
		
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>			
<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		



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
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer" onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
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
																			<td bgcolor="#ffffff" width="550px" colspan="3">
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
																<%
																/*---------------------------------------------------------------------------->
																	HTML Desc	: �˻� ���� - ����,������:  
																	Object ID 	: �׸��� , gr1
																	Data ID		: ds1
																-----------------------------------------------------------------------------*/
																%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:400" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name="Format" 			value="
																			<C> name='���SID' 		ID='saup_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
																			<C> name='������SID' 		ID='upjang_sid' 				 	HeadAlign=Center Width=100  align=left editlimit=10 show=false</C>																																																									
																			<C> name='�������' 		ID='upjang_nm' 				 	HeadAlign=Center Width=120  align=left editlimit=30 BgColor=#fefec0 edit=none</C>																					
																			<C> name='����'  		ID='use_yn'   	HeadAlign=Center Width=30 align=center editlimit=1 editstyle=checkbox</C>																														
																			<C> name='��������' 	ID='bgn_date' 				 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
																			<C> name='��������' 	ID='end_date' 				 	HeadAlign=Center Width=80  align=center editlimit=26 mask='XXXX-XX-XX'</C>
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
<input type="hidden" name="row" value="">

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

