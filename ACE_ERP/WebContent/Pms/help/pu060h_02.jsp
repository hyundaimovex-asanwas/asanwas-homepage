<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 		: �����ݾ�����  Help 
 * ���α׷�ID 	: pu060h_02
 * J  S  P		    : pu060h_02
 * �� �� ��		: pu060h_02
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-11-25
 * �������		: �����ݾ����� help
 * [���� �� ��][������] ����
 * [2012-11-02][�ɵ���] ITEM_SEQ  �߰� 
 *****************************************************************************/
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	// �븮�� ����
	String title = "�����ݾ� �Է�";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>�����ݾ� �Է�</title>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			var strParam=window.dialogArguments;
			var sest_sid = strParam.ds_detail.namevalue(strParam.ds_detail.rowposition,"EST_SID");
			var svend_cd = strParam.ds_detail.namevalue(strParam.ds_detail.rowposition,"VEND_CD");
			var stot_est_amt = strParam.ds_detail.namevalue(strParam.ds_detail.rowposition,"TOT_EST_AMT");
			
			//alert("sest_sid::"+sest_sid);
			//alert("svend_cd::"+svend_cd);
			
			function fnOnLoad() {
			    cfStyleGrid(getObjectFirst("gr1"), "comn");
			    fnSelect();
			}
			
			function fnSelect() {
			   
			    v_job="S";
				ds_detail.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Pu060H_02?proType=S&dsType=1&sest_sid=" + sest_sid+"&svend_cd="+svend_cd;
				
				ds_detail.Reset();
			}
			
			function fnClose() {
				window.close();
			}
			
				
			//ó����ư : �ܰ��Է� ����� ȭ�鿡 �����ش�.
			function fnSettle() {
				if(ds_detail.ConutRow <1) return;
			
				if(v_job!="calc"){
					for( i=1; i<=ds_detail.CountRow; i++ ) {
						var est_amt 	= 0; //�ܰ�
						var est_item_cnt = 0; //����
						var sum_amt= 0; //�ܰ�*����

						getObjectFirst("ds_detail").NameValue(i, "FN_SUM_AMT")=getObjectFirst("ds_detail").NameValue(i, "FN_EST_AMT") * getObjectFirst("ds_detail").NameValue(i, "EST_ITEM_CNT");
				    }
					//v_job="calc"; //1�� ó���ϸ� ������ calc�� �־��ش�.2008-07-10
				}else{
				 alert("�̹� ó����ư�� �����̽��ϴ�.\n���� �Ǵ� ��� ��ư�� �����մϴ�.");
				 }
			}
			
			//�����ܰ��� �����ܰ� ������ ���� 
			function fnCopy(){
				if(ds_detail.ConutRow <1) return;
			
				for( i=1; i<=ds_detail.CountRow; i++ ) {
					getObjectFirst("ds_detail").NameValue(i, "FN_EST_AMT")=getObjectFirst("ds_detail").NameValue(i, "EST_AMT");
			    }

			
			
			}
			
			function fnApply(){
		   
		        v_job = "I";	
		         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
		        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
		                    + ",sest_sid="+ sest_sid
		                    + ",svend_cd="+ svend_cd;

		         ln_TRSetting(tr1, 
		             "<%=dirPath%><%=HDConstant.PATH_HELP%>Pu060H_02",
		             "JSP(I:DEFAULT=ds_detail)",
		             v_param);
		             //prompt('',ds_detail.text);
	             tr_post(tr1);

			}
			
		    function fnCancel(){
				ds_detail.undoAll();
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
	   //alert("���强��");
        if(v_job=="I") {
	        alert("���������� ����Ǿ����ϴ�.");
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            window.returnValue = "Y"+ ";" 
            window.close();
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            window.returnValue = "Y"+ ";" 
            window.close();
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
            window.returnValue = "N"+ ";" 
            window.close();
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            window.returnValue = "N"+ ";" 
            window.close();
        
        //�����޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
	</script>		
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	    if(Row==0) {	//�������� Ŭ��������.
	        if(ds_detail.CountRow<=1) return;
	        gr1.Redraw = "False";
	      
	        //���� 
	        if(Colid=="EST_AMT"){
	            for(var i=2; i<=ds_detail.CountRow; i++){
	                ds_detail.NameValue(i, Colid) = ds_detail.NameValue(1, Colid);
	            }
	        }
	        gr1.Redraw = "True";
	        return;
	    }
	</script>	
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds_detail event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds_detail event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds_detail event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>	

<%=HDConstant.COMMENT_START%>		
<object  id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:350px;">
						<tr>
							<td  height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=left><font style="position:relative;top:1px;width:540;height:15;left:5px;"><%=title%></font>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:300px">
						<tr>
							<td align=right>
								<img src="<%=dirPath%>/Sales/images/copy.gif"		style="cursor:pointer;"  	onclick="fnCopy()">
								<img src="<%=dirPath%>/Sales/images/settle.gif" 	style="cursor:pointer" 	onClick="fnSettle();">
							    <img src="<%=dirPath%>/Sales/images/save.gif"	 	style="cursor:pointer;"  	onClick="fnApply()">
								<img src="<%=dirPath%>/Sales/images/p_exit.gif"		style="cursor:pointer;" 	onClick="fnClose()">  
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds_detail
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%>  style="width=950px; height:400px;border:1 solid #777777;">
						<param name="DataID"		  value="ds_detail">
						<param name="BorderStyle"   VALUE="0">
                		<param name=ColSizing         value="true">
                		<param name="editable"         value="true">
                		<param name=UsingOneClick  	value="1">
                        <Param Name="AllShowEdit"   value="True">
                        <param name=ViewSummary value=1>
						<param name="Format" 		  value="
							<c> Name='����SID'				ID='EST_SID'		     Width=60  align=center   edit = none show=false</c>
		                    <C> name='����' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
							<c> Name='ǰ��SID'				ID='ITEM_SID'		     Width=60  align=center   edit = none  show=false</c>
							<c> Name='�ŷ�ó�ڵ�'		ID='VEND_CD'		     Width=60  align=center   edit = none show=false</c>							
							<c> Name='ǰ��'		ID='ITEM_NM'		     Width=220  align=center   edit = none  SumText='�հ�'     suppress=1 </c>
							<c> Name='�԰�' 		ID='ITEM_SIZE'	  	 Width=220  align=center   edit = none  </c>
							<c> Name='���� ' 	ID='ITEM_UNIT'	  	 Width=60  align=center   edit=none  </c>
							<c> Name='����' 		ID='EST_ITEM_CNT'	 Width=60  align=center   edit=none dec=0</c>
							<c> Name='�����ܰ�' 	ID='EST_AMT'	  	Width=100  align=right      edit=none	SumText=@sum	dec=0	</c>
							<c> Name='�����ܰ�V' 	ID='FN_EST_AMT'	  	Width=100  align=right      edit=true	SumText=@sum	dec=0	bgColor=<%=HDConstant.GRID_ITEM%></c>
							<c> Name='�����ݾ�' 	ID='FN_SUM_AMT'		Width=140  align=right      edit=none	SumText=@sum	dec=0	</c>
						">
												
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<!--  ���¹� �÷���. src ����� .swf�� ���� �ִ� ���� ������ ��ġ�� ������ ����Ŵ 
				���� .swf�� ���� �������� src�� �����ؼ� �ε�ȭ���� �����ִ� ���� ���� ��.
				������ �ε�ȭ���� ��� ���ٰ� �����ϱ� ��.
				�ش� �������� TIP�� �� �ִ�? ���� �ð��� �ȵ�;;; ��.. -->
			<iframe id="LowerFrame" 
				name="work" 
				style="display:none; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.jpg" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>