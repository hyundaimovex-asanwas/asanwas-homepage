<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ŷ�ó ��� (�����) - ��Ϲ�ȣ �ߺ� üũ 
+ ���α׷� ID:  a010050_popup.jsp
+ �� �� �� ��	:  ��Ϲ�ȣ �ߺ� üũ 
+ ��   ��  ��	:  ������
+ �� �� �� ��	:  2012.08.21
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
<title>��Ϲ�ȣ �ߺ� üũ</title>

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

var g_strcomgb="" ; //��ü����

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  gcra_usegb.codevalue ="1";

	var strParam = new Array();
	strParam=window.dialogArguments;

	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

}

/******************************************************************************
	Description : ��Ϲ�ȣ �ߺ�üũ 
******************************************************************************/
function ln_Query2(){
    var intChk=0;
    var strGB="";
    
    if(gcem_vend_id.text==""){
    	alert("��Ϲ�ȣ�� �Է��Ͻʽÿ�.");
    	return false;
    }
	txt_msg.value="";
	intChk = gcem_vend_id.text.length;
	
	//alert("intChk::"+intChk);

    if (intChk==10){          //����ڹ�ȣ üũ 
    	if(!gf_Wkresino(gcem_vend_id.text)){
    	    txt_msg.value="����ڹ�ȣ�� ���� �ʽ��ϴ�.";
    		return false;
    	}
    }else if(intChk==13){   //�ֹι�ȣ �� �ܱ��� ��Ϲ�ȣ üũ 
    	strGB = gcem_vend_id.text.substring(6,7);

    	//alert("strGB::"+strGB);
    		
    	if(strGB=="1"||strGB=="2"||strGB=="3"||strGB=="4"){             //�ֹι�ȣ 
    		if(!gf_Resino(gcem_vend_id.text)){
	    	    txt_msg.value="�ֹε�Ϲ�ȣ��  ���� �ʽ��ϴ�.";
	    		return false;
	    	}
    	}else if (strGB=="5"||strGB=="6"||strGB=="7"||strGB=="8"){ //�ܱ��� ��Ϲ�ȣ 
    		if(!gn_FgResino(gcem_vend_id.text)){
	    	    txt_msg.value="�ܱ��ε�Ϲ�ȣ��   ���� �ʽ��ϴ�.";
	    		return false;
	    	}
    	}			
    }else{
    	txt_msg.value="��Ϲ�ȣ �ڸ����� Ʋ���ϴ�.";
        return false;
    }
	
	txt_vend_id.value= gcem_vend_id.text;
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s2?v_str1="+gcem_vend_id.text;           
	//prompt('',gcds_code01.DataID );                
	gcds_code01.Reset();
	
	
	if(gcds_code01.namevalue(gcds_code01.rowposition,"VEND_CNT")>0){
	    sp0.style.display = "none"; //����
		txt_msg.value="��Ϲ�ȣ�� �����մϴ�. ��ϺҰ��մϴ�.";
    }else{
        sp0.style.display = "";
    	txt_msg.value="��ϰ����� ��Ϲ�ȣ�Դϴ�.";
    }
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

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

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Return(){

    if(txt_vend_id.value!= gcem_vend_id.text){
    	alert("��Ϲ�ȣ�� ���� ������ �� �����ϴ�.");
    	return false;
    }

	window.returnValue = gcem_vend_id.text+";"+gcra_usegb.codevalue; 
	window.close();
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">

</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcra_usegb event=OnSelChange()>
	if(gcra_usegb.codevalue=="1"){ //
		gcem_vend_id.Format = "000-00-00000";      //���� , ���� ����ڵ�Ϲ�ȣ
	}else if(gcra_usegb.codevalue=="2"){
		gcem_vend_id.Format = "000000-0000000";  //�ֹι�ȣ 
	}
	
	sp0.style.display = "none"; //����
	txt_msg.value="";
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
	<tr>
	    <td width="190px" colspan=2 align="left"><font color="#0000FF"><b>*��Ϲ�ȣ �ߺ�üũ</b></font></td>
		<td width="288px" colspan=2 align="right">
			<img src="../../Common/img/btn/com_b_find.gif" alt="��Ϲ�ȣ �ߺ� �˻��մϴ�" style="position:relative;left:-2px;top:1px;cursor:hand;" onclick="ln_Query2()">
		</td>
	</tr>
	<tr>
	   <td class="tab14"  width="70px" bgcolor="#eeeeee" align="center">��ȣ����</td>
	   <td class="tab14"  width="160px">&nbsp;
			<comment id="__NSID__">
			<object id=gcra_usegb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-2px;top:2px;width:160px;height:20px;">
				<param name=Cols		value="2">
				<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td> 
	
		<td class="tab14" width="70px" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td class="tab31" width="170px" style="height:25px"><comment id="__NSID__">
				<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:2px;top:0px">		
						<param name=Text				value="">
						<param name=Alignment      value=0>
						<param name=Border          value=true>
						<param name=Numeric        value=false>
						<param name=Format          value="000-00-00000">
						<param name=PromptChar  value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=readOnly       value=false>
				 </object>
			</comment><script>__ws__(__NSID__);</script>
			<input id="txt_vend_id"   type="hidden"   class="txtbox"  style= "position:relative;left:5px;width:0px;height:20px;">
		</td>
	</tr>
	<tr>
	   <td class="tab12" width="70px" bgcolor="#eeeeee" align="center">�����</td>
	   <td width="400px;"  style="text-align:left"  colspan =3><nobr>
			 <input id="txt_msg"   type="text"   class="txtbox"  style= "position:relative;left:5px;top:-1px;width:300px;height:20px;color:#ff0000;">&nbsp;&nbsp;&nbsp;
			<span id=sp0 style="display:none;">
		    	<img src="../../Common/img/btn/com_b_banyoung.gif" alt="��Ϲ�ȣ ����" style="position:relative;left:60px;top:3px;cursor:hand;" onclick="ln_Return()">
		    </span>
		    </nobr>
		</td>
	</tr>
	
</table>


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:100px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
