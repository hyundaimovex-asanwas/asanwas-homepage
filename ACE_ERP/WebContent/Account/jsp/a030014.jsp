
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �������� - ���� ������
+ ���α׷� ID	:  A030014.html
+ �� �� �� ��	:  
+ ��   ��  �� :  YS.JEONG
+ �� �� �� �� :  2006.09.19
-----------------------------------------------------------------------------
+ �� �� �� ��  :	 �������� ���� �� ��¹� �ۼ�  
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.10
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����ǰ������</title>

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
//get_cookdata();
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //���
var gs_date3 = gcurdate.substring(0,4); //��
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var g_date,g_time;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	gclx_fdcode.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){

	gcds_data01.clearall();
	gcds_temp01.clearall();

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030014_s1?v_str1="+gclx_fdcode.bindcolval
		   +"&v_str2="+gcem_datefr.text;
		 //  +"&v_str3="+//gcem_atcode_fr01.text
		 //  +"&v_str4="+;//gcem_atcode_to01.text;
																								  																										
	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									
	
}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
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
 
  //alert("������");
	//return;

	var time = new Date();

	gcds_temp01.clearall();
	ln_PrintHeader();
	gcds_temp01.addrow();
	
	if(time.getMonth()+1<10)
		g_date = time.getFullYear()+"/0"+(time.getMonth()+1)+"/"+time.getDate();
	else
		g_date = time.getFullYear()+"/"+(time.getMonth()+1)+"/"+time.getDate();
	if(time.getHours()<10) {
		if(time.getMinutes()<10)
			g_time = "0"+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = "0"+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()>=10&&time.getHours()<12) {
		if(time.getMinutes()<10)
			g_time = ""+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = ""+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()==12) {
		if(time.getMinutes()<10)
			g_time = "12:0"+time.getMinutes()+" PM";
		else
			g_time = "12:"+time.getMinutes()+" PM";
	} else if(time.getHours()>12&&time.getHours()<22) {
		if(time.getMinutes()<10)
			g_time = "0"+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = "0"+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	} else {
		if(time.getMinutes()<10)
			g_time = ""+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = ""+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	}

	if(gcds_data01.countrow<1)
			alert("����� ������ �����ϴ�.");
	else {
		var fdcodenm;
		if(gclx_fdcode.BindColVal=="")
			fdcodenm = "����ƻ��ֽ�ȸ��";
		else
			fdcodenm = gclx_fdcode.text;
		gcds_temp01.namevalue(1,"TITLE") = "���� " + fdcodenm + " �ǰ������";
//		gcds_temp01.namevalue(1,"FDCODENM") = "������ : " + fdcodenm + "  " +txt_costnm_fr.value;

		gcds_temp01.namevalue(1,"CURDT") = "������� : " + g_date;
		gcds_temp01.namevalue(1,"CURTM") = "��½ð� : " + g_time;
		gcds_temp01.namevalue(1,"KISU1") = "( "+gcem_datefr.text+"�⵵ )";//���
		gcrp_print1.preview();
	}

}

/******************************************************************************
	Description : ��� - Header Set
******************************************************************************/
function ln_PrintHeader() {
		if(gcds_temp01.countrow<1){
	   var s_temp = "TITLE:STRING,KISU1:STRING,FDCODENM:STRING,CURDT:STRING,CURTM:STRING,ATKORNAM:STRING";
		 gcds_temp01.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	
	//gcgd_disp01.runexcel("�����ǰ������");
     gcgd_disp01.GridToExcel("�����ǰ������","",2);
	
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
  
	//�⵵
	gcem_datefr.text = gs_date3; //�⵵
	
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//�����
	//gcds_place.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2159"; 
	//prompt("", gcds_place.DataID);
	//gcds_place.Reset();

	//���
	//gcds_staxdatki.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2137"; 
	//gcds_staxdatki.Reset(); 

	/* 
	//����/�����ڵ�
	gcds_sfdcode2.DataID = "/services/servlet/Account.a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_staxdatki.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //���
	*/
}

/******************************************************************************
	Description : �����˾�
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0030";//�����ڵ�

	if(gclx_place.bindcolval!=""){
		arrParam[1]=gclx_place.bindcolval;//������ڵ�
  }else{
    arrParam[1]="";
	}

	if(txt_costnm_fr.value==""){
		 arrParam[2]="";
	}else{
     arrParam[2]=txt_costnm_fr.value;
	}

	if(txt_costcd_fr.value==""){
     arrParam[3]="";
	}else{
     arrParam[3]=txt_costcd_fr.value;
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_costcd_fr.value =arrResult[0];
		txt_costnm_fr.value = arrResult[1];
	}else{
    txt_costcd_fr.value="";
		txt_costnm_fr.value="";
	}
}

/******************************************************************************
	Description : ��¥���
	prameter    : 
******************************************************************************/

/**
 * Time ��Ʈ���� �ڹٽ�ũ��Ʈ Date ��ü�� ��ȯ
 * parameter time: Time ������ String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1��=0,12��=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * �ڹٽ�ũ��Ʈ Date ��ü�� Time ��Ʈ������ ��ȯ
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1��=0,12��=11�̹Ƿ� 1 ����
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * �־��� Time �� y�� m�� d�� ���̳��� Time�� ����
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 ���κ��� 100�� �� Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y���� ����
    date.setMonth(date.getMonth() + m);       //m���� ����
    date.setDate(date.getDate() + d);         //d���� ����

    return toTimeString(date);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--(��)�������� ��ȸ  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�����  -->
<!--comment id="__NSID__"><object  id=gcds_place classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script--> 

<!-- ��� -->
<!--comment id="__NSID__"><object  id=gcds_staxdatki classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script--> 

<!--(��)�������� ��ȸ ����  -->
<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
    //ln_Data_Reset(); //����Ÿ �缳��
		ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_staxdatki" event="onloadCompleted(row,colid)">

</script>

<script language="javascript" for="gcds_place" event="onloadCompleted(row,colid)">
	//gcds_place.InsertRow(1);
	//gcds_place.NameValue(1,"CDCODE")="";
	//gcds_place.NameValue(1,"CDNAM")="��ü";
	//gclx_place.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030014_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right">&nbsp;
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>�����ڵ�</td>
				<td class="tab18" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab18" style="height:30px;width:597px;">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:35px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			
<!-- 
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>�� �� ��</td>
        <td class="tab19" width="690px" colspan=3>
				  <nobr>
					<input id="txt_vendnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('fr');">
					<input id="txt_vendcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_vendnm_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('to');">
					<input id="txt_vendcd_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>

				<td class="tab19" style="width:797px" colspan="3"><nobr>
					<object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 

					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled>
					&nbsp;&nbsp;~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr> -->
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:430px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<param name="colsizing"     value="true">
							<param name=viewsummary   value=1>
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='�����ڵ�'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center SumBgColor=#C3D0DB SumText='��' sort=false show=false</FC> 
								<FC> Name='��������'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left SumBgColor=#C3D0DB SumText='��' sort=false</FC> 
								<C> Name='1��'    	ID=A01    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='2��'	    ID=A02    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='3��'    	ID=A03    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='4��'	    ID=A04    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='5��'    	ID=A05    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='6��'	    ID=A06    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='7��'    	ID=A07    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='8��'	    ID=A08    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='9��'    	ID=A09    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='10��'	    ID=A10    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C> 
								<C> Name='11��'	    ID=A11    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='12��'	    ID=A12    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
                <C> Name='��'	      ID=TSUM   HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right SumBgColor=#C3D0DB SumText=@sum</C>
								   
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">��ȸ�Ǽ� : </font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_temp01">
	<param name="DetailDataID"			value="gcds_data01">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="true">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=450 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=960 ,top=108 ,right=1960 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=950 ,top=98 ,right=1950 ,bottom=176 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='KISU1', left=1013, top=190, right=1893, bottom=241, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=70 ,top=370 ,right=2808 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=2645 ,top=389 ,right=2780 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12��' ,left=2460 ,top=389 ,right=2595 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11��' ,left=2275 ,top=389 ,right=2410 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10��' ,left=2090 ,top=389 ,right=2225 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9��' ,left=1905 ,top=389 ,right=2040 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8��' ,left=1720 ,top=389 ,right=1855 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7��' ,left=1535 ,top=389 ,right=1670 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4��' ,left=975 ,top=389 ,right=1110 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5��' ,left=1165 ,top=389 ,right=1300 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6��' ,left=1348 ,top=389 ,right=1483 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3��' ,left=795 ,top=389 ,right=930 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2��' ,left=610 ,top=389 ,right=743 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=105 ,top=389 ,right=373 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1��' ,left=423 ,top=389 ,right=558 ,bottom=434 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=70 ,top=450 ,right=2808 ,bottom=450 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TITLE', left=955, top=103, right=1945, bottom=169, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='FDCODENM', left=80, top=314, right=1008, bottom=361, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='TSUM', left=2620, top=7, right=2808, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A12', left=2433, top=7, right=2623, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A11', left=2245, top=7, right=2438, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A10', left=2060, top=7, right=2253, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A09', left=1875, top=7, right=2065, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A08', left=1690, top=7, right=1880, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A07', left=1505, top=7, right=1700, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A06', left=1320, top=7, right=1510, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A05', left=1135, top=7, right=1325, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A04', left=950, top=7, right=1140, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A03', left=763, top=7, right=953, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A02', left=575, top=7, right=765, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A01', left=385, top=7, right=578, bottom=49, align='right', face='����', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=80, top=7, right=390, bottom=49, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2870 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=70 ,top=0 ,right=2808 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=70 ,top=63 ,right=2808 ,bottom=63 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(TSUM)}' ,left=2620 ,top=12 ,right=2808 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A12)}' ,left=2435 ,top=12 ,right=2623 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A10)}' ,left=2065 ,top=12 ,right=2253 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A11)}' ,left=2250 ,top=12 ,right=2438 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A08)}' ,left=1693 ,top=12 ,right=1880 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A09)}' ,left=1880 ,top=12 ,right=2065 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A07)}' ,left=1508 ,top=12 ,right=1695 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A06)}' ,left=1323 ,top=12 ,right=1510 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A04)}' ,left=950 ,top=12 ,right=1140 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A05)}' ,left=1138 ,top=12 ,right=1325 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A02)}' ,left=575 ,top=12 ,right=765 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A03)}' ,left=763 ,top=12 ,right=953 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A01)}' ,left=385 ,top=12 ,right=578 ,bottom=54 ,align='right' ,face='����ü' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<T>id='��' ,left=80 ,top=12 ,right=390 ,bottom=54 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2870 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2418 ,top=2 ,right=2798 ,bottom=84</I>
	<L> left=70 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=1245 ,top=54 ,right=1668 ,bottom=96 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=80, top=14, right=480, bottom=59, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURTM', left=475, top=14, right=820, bottom=59, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
