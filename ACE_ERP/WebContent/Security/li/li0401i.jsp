<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: ��������>��������>�μ�����>�μ���Ī
* ���α׷� ID	: li0401i.jsp
* �� �� �� ��	: �μ���Ī
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2011.10.28
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>�μ���Ī</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    fnInit();

   // txt_own_dpt.value = gdeptcd;
   // txt_own_dptnm.value = gdeptnm;
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){
    ds_wrk_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI007&s_item1=Y";
    ds_wrk_div.Reset(); //�߽ű���
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_wrk_div="+gclx_wrk_div.bindcolval;

    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0400I",  "JSP(O:DS_DEFAULT=ds_default)",  param);     
    tr_post(tr1);

}

/******************************************************************************
	Description : �ű�
******************************************************************************/
function fnAddRow(){
	ds_default.addrow();
}


/******************************************************************************
	Description : ����
******************************************************************************/
function fnApply(){
	  if (ds_default.IsUpdated) {
        if (fnChk()) {
            ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0400I",  "JSP(I:DS_DEFAULT=ds_default)",  "proType=A, dsType=1");
            tr_post(tr1);
        }else{
        	return;
        }
    }else{
    	alert("������ �����Ͱ� �������� �ʽ��ϴ�.");
    	return;
    }
    
    fnSelect();
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
 function fnChk() {    
 	return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
 function fnCancel() {           
    ds_default.undoall();
    window.status="�ڷ� ������ ��ҵǾ����ϴ�.";      
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_wrk_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if(ds_default.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
			<img src="<%=dirPath%>/Sales/images/new.gif"	    style="cursor:hand" onclick="fnAddRow()">
			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onclick="fnApply()">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand" onclick="fnCancel()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>��������</td>
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_wrk_div  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_wrk_div">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>�λ�μ���</td>
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_wrk_div  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_wrk_div">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>�����μ���</td>
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_wrk_div  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_wrk_div">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="true"> 
					<param name=TitleHeight      value="30">
					<param name="Format"	 	 value=" 
					<C> Name='��������'	      ID=WRK_DIV             HeadAlign=Center  HeadBgColor=#B9D4DC Width=80 	align=center  EditStyle=Lookup	Data='ds_wrk_div:detail:detail_nm' </C>
					<C> Name='�μ��ڵ�' 	      ID=MAG_DPT_CD     HeadAlign=Center  HeadBgColor=#B9D4DC Width=100 	align=center  </C>
                    <C> Name='�μ���'             ID=MAG_DPT_NM    HeadAlign=Center  HeadBgColor=#B9D4DC Width=200 	align=left        </C>
                    <C> Name='�����μ��ڵ�'   ID=HIG_DPT_CD       HeadAlign=Center  HeadBgColor=#B9D4DC Width=100 	align=center  </C>
					<C> Name='�μ�����'         ID=DPT_LVL	          HeadAlign=Center  HeadBgColor=#B9D4DC Width=100 	align=center  </C>
					<C> Name='��������'  	      ID=SRT_DT              HeadAlign=Center  HeadBgColor=#B9D4DC Width=100 	align=center  mask ='XXXX/XX/XX'</C>
					<C> Name='��������'  	      ID=END_DT              HeadAlign=Center  HeadBgColor=#B9D4DC Width=100 	align=center  mask ='XXXX/XX/XX'</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 