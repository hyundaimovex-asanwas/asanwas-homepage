<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �������ݰ�꼭 - �������� ����
+ ���α׷� ID	:  a040077_popup2.jsp
+ �� �� �� ��	:  ��������
+ ��   ��   ��     :  �� �� ��
+ �� �� �� ��	:  a040077_popup2_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���ʽ��ι�ȣã��</title>


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
******************************************************************************/
function ln_Start(){
	 
	//txt_atcode_fr.value= strParam.g_arrParam[0];
}
/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(e){

	
}

/******************************************************************************
Description : â�ݱ�
parameter   : A - ����
******************************************************************************/
function ln_Close(){
	
	var returnval="";
	
	if(rdoType01.checked==true){
		returnval="01"; 
	}else if (rdoType011.checked==true){
		returnval="011";
    }else if (rdoType06.checked==true){
    	returnval="06";
	}else if (rdoType02.checked==true){
		returnval="02";
	}else if (rdoType04.checked==true){
		returnval="04";
	}else if (rdoType03.checked==true){
		returnval="03";
	}else if (rdoType05.checked==true){
		returnval="05";
	}else if (rdoType051.checked==true){
		returnval="051";
	}
	
	window.returnValue = returnval;   
	window.close();
}




/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<!-- ���� ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr>
		<td height="40px">
			<b><font size="3" color="blue">&nbsp;�� ������������</font></b>
		</td>
		<td align = right> 	
			<img src="../../Common/img/btn/com_b_select.gif"  style="cursor:hand;"   onClick="ln_Close()"> 
		<td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px" colspan =2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:1 solid #708090'>
				<!-- ������� ���� ���� 01 -->
				<tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =3 >
						<nobr><b><font size="2" color="blue">������� ���� ���� ��</font></b></nobr></td>
					</td>
					<td class="tab22" style="width:470px;height:30px" colspan =2>
						<nobr><b>�ʿ��� ������� ���� ���� �Ǵ� ���� ���� ������ �߸� �߱��ϴ� ���, ������ �߸� �����Ͽ� �߱��� ���</b></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab21" style="height:30px" >
					   <nobr> <input type="Radio" name="rdoType" id="rdoType01" value="01" >
					          <b><font color="blue">���� ���ݰ�꼭</font></b></nobr></td>
						</nobr>
					</td>
					<td class="tab22" ><nobr>��(-)�� ���ݰ�꼭 ���� (�ۼ����� : ���� �ۼ���)</nobr></td>
				</tr>
				<tr>
					<td class="tab21" >
						<nobr><input type="Radio" name="rdoType" id="rdoType011" value="011" >
					          <b><font color="blue">������ ���ݰ�꼭</font></b>
					    </nobr>
					</td>
					<td class="tab22" ><nobr>������ ������ (+)���ݰ�꼭 ����<BR> (�ۼ����� : ���� �ۼ����� ��Ģ�̳� �ۼ����� �� �� ����� ��� �ùٸ� �ۼ����� ���� )</nobr></td>
				</tr>
				
				<!-- ������ ���� ���߹߱� �� 06-->
				<tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =2 >
						<nobr><b><font size="2" color="blue">������ ���� ���߹߱� ��</font></b></nobr></td>
					</td>
					<td class="tab22" style="height:30px"  colspan=2>
					   <nobr><b>������ ���� �߱��� ���, �鼼 �� �߱޴���� �ƴ� �ŷ� � ���Ͽ� �߱��� ���</b></nobr></td>
				</tr>
				<tr>
					<td class="tab21" style="height:30px" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType06" value="06" >
					   		 <b><font color="blue">������ ���� ���߹߱� ��</font></b>
					   </nobr>
					</td>
					<td class="tab22" ><nobr>��(-)�� ���ݰ�꼭�� �����մϴ�. (�ۼ����� : ���� �ۼ���)</nobr></td>
				</tr>
			
			
			    <!-- ���ް��� ���� 02 -->
			    <tr>
					<td class="tab11" style="width:20px;height:30px" bgcolor="#eeeeee">
						<nobr><b><font size="2" color="blue">���ް��� ����</font></b></nobr></td>
					</td>
					<td class="tab21" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType02" value="02" >
					   		 <b><font color="blue">���ް��� ����</font></b>
					   </nobr>
					</td>
					<td class="tab22"   >
					   <nobr>�����Ǵ� �ݾ׿� ���� ��(+) �Ǵ� ��(-)�� ���ݰ�꼭�� �����մϴ�.<br/>
                             (�ۼ����� : �������� �߻���) <br />
                       <b><font color="red">���1�� : ���� ���ݰ�꼭 �ۼ����� ����</font></b> 
                       </nobr>
                    </td>
				</tr>
				
			    
			    <!-- ����� ����   04-->
			    <tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =4 >
						<nobr><b><font size="2" color="blue">����� ����</font></b></nobr></td>
					</td>
					<td class="tab21" style="height:30px" rowspan =4 >
					   <nobr><input type="Radio" name="rdoType" id="rdoType04" value="04"  >
					   		 <b><font color="blue">����� ����</font></b>
					   </nobr>
					</td>
					<td class="tab22" style="height:30px" >
					   <nobr><b>������(2012.06.30 ����)</b></nobr>
					</td>
				</tr>
				<tr>
					<td class="tab22" ><nobr>��(-)�� ���ݰ�꼭�� �����մϴ�.(�ۼ����� : ���� �ۼ���)<br/>
					<b><font color="red">���1�� : ��� ������ ����</font></b>
					</nobr></td>
				</tr>
				<tr>
					<td class="tab22" style="height:30px"><nobr><b>������(2012.7.1 ����)</b></nobr></td>
				</tr>
				<tr>
					<td class="tab22" ><nobr>��(-)�� ���ݰ�꼭�� �����մϴ�.(�ۼ����� : ��� ������)<br/>
					<b><font color="red">���1�� : ���� �ۼ��� ����</font></b>
				</nobr></td>
				</tr>
			    
			    <!-- ȯ�� 03 -->
			     <tr>
					<td class="tab11" style="width:20px;height:30px" bgcolor="#eeeeee">
						<nobr><b><font size="2" color="blue">ȯ��<font></b></nobr></td>
					</td>
					<td class="tab21" >
					   <nobr><input type="Radio" name="rdoType" id="rdoType03" value="03" >
					   		 <b><font color="blue">ȯ��</font></b>
					   </nobr>
					</td>
					<td class="tab22"   >
					   <nobr>ȯ�� �ݾ׺п� ���Ͽ� ��(-)�� ���ݰ�꼭�� �����մϴ�.<br/>
                             (�ۼ����� : ȯ�Ե� ��) <br />
                       <b><font color="red">���1�� : ���� ���ݰ�꼭 �ۼ����� ����</font></b> 
                       </nobr>
                    </td>
				</tr>
			    
			    
			    <!-- �����ſ��� ���� ���� 05 -->
			    <tr>
					<td class="tab11" style="width:20px;" bgcolor="#eeeeee" rowspan =2 >
						<nobr><b><font size="2" color="blue">�����ſ��� ���İ���</font></b></nobr></td>
					</td>
					<td class="tab21" style="height:30px" >
					   <nobr> <input type="Radio" name="rdoType" id="rdoType05" value="05" >
					          <b><font color="blue">���� ���ݰ�꼭</font></b></nobr></td>
						</nobr>
					</td>
					<td class="tab22" ><nobr>������ �ݾ׸�ŭ ��(-)�� ���ݰ�꼭 ���� (�ۼ����� : ���� �ۼ���)</nobr></td>
				</tr>
				<tr>
					<td class="tab21" >
						<nobr><input type="Radio" name="rdoType" id="rdoType051" value="051" >
					          <b><font color="blue">������ ���ݰ�꼭</font></b>
					    </nobr>
					</td>
					<td class="tab22" ><nobr>������(+)���ݰ�꼭 ���� (�ۼ����� : ���� �ۼ��� ) <BR>
					<b><font color="red">���1�� : �����ſ밳������ ����</font></b> 
					</nobr></td>
				</tr>				
			</table>
		</td>
	</tr>
    <tr>			
		<td>	
			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [HEAD]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_head classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_head>
	<param name=BindInfo		value='  
		<C>Col=VENDNM			Ctrl=gcem_vendnm0				Param=text</C>
		<C>Col=VENDID			Ctrl=gcem_vendid0				Param=text</C>
		<C>Col=VDDIRECT	  Ctrl=gcem_vddirect0			Param=text</C>
		<C>Col=VENDNO		  Ctrl=gcem_vendno0			  Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [DATA2]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
