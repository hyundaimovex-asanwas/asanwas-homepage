<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ���ڼ��ݰ�꼭 - ������� - ��� �� �źλ��� �Է� �˾�
+ ���α׷� ID	:  Comfirm_popup.html
+ �� �� �� ��	:  ��� �� �źλ��� �Է� �˾�
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2009.07.01
-----------------------------------------------------------------------------
+ �� �� �� �� :	 
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���� �Է�</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
	              ��ǥ�� ������ ���� ���� üũ�ؼ� �����ϸ� ����
								�������� ������ �ڱ� üũ�ؼ� �ڱ����� �ϸ� �ڱ�
******************************************************************************/
function ln_Start(){
	var strParam=window.dialogArguments;
  txt_title.value =strParam[0];
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){ 

  if(txt_sbdescription.value==""){
	  alert("������ �ʼ��׸��Դϴ�. �Է��� �ֽʽÿ�.")
		return;
	}

	window.returnValue = txt_sbdescription.value ; 
	window.close();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Close(){ 
	window.close();
}

/******************************************************************************
	Description : â�� ������ ���� �߻��ϴ� �̺�Ʈ 
	              Ȯ��, ���, X��ư ��� �� �Լ��� ź��.
								���� �����Ͽ� �����ؾ��� �� ����.
******************************************************************************/
function ln_End(){
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()"  onbeforeunload="ln_End()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:330px">
	<tr>
		<td  width="150" align="left" style="padding-top:4px;">
			<input type="text" class="txt41"  id="txt_title"  style="background-color:#FFFF99;border:0;font-size:15;font-weight:bold" readOnly></td>
    </td>
		<td  width="180" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_btn_send.gif"  style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Close()">
		</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:6px;top:5px;width:330px;border:1 solid #708090">
   <tr>
			<td>
				 <textarea id="txt_sbdescription" class="txtbox"  style= "position:relative;left:2px;width:324px;height:50px; overflow:auto;"  maxlength="30"></textarea>
      </td>
	 </tr>
	  <tr>
			<td height="3"></td>
	 </tr>
	  <tr>
			<td style="background-color:#FFCCFF;border:0;font-size:15;font-weight:bold">
				 <font size=2 > *���� �����ؼ� 30�� �̳��� �Է��� �ֽʽÿ�.</font>
      </td>
	 </tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
