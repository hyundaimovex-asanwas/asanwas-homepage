<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ������ - �ϰ�ǥ
+ ���α׷� ID	: A030006
+ �� �� �� ��	: ��ȸ, ���
+ �� �� �� ��	: ������
+ �� �� �� ��	: a030006_s1, a030006_s2
-----------------------------------------------------------------------------
+ �� �� �� ��  :	 ��¹�����  
+ ��   ��  ��  :  �Ϲμ�
+ �� �� �� ��  :  2006.3.15
-----------------------------------------------------------------------------
+ �� �� �� ��  :	�ϰ�ǥ ���� ���� (���ڸ� from ~ to) 
+ ��   ��  ��  :  ������
+ �� �� �� ��  :  2006.10.18
------------------------------------------------------------------------------
+ �� �� �� ��  :	�ϰ�ǥ ��������(�Ұ� ������ Ʋ��) �� ��¹�����(��ǥ�ż� �߰� �� page skip)
+ ��   ��  ��  :  ������
+ �� �� �� ��  :  2007.05.16
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ϰ�ǥ</title>
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

var gs_date = gcurdate.substring(0, 4) + gcurdate.substring(5, 7) + gcurdate.substring(8, 10);
var gs_date2=""; //���� ��(�����̿� ����.)
var gs_date3=""; //������ �Ϸ� ����
var gs_date4=""; //����� ��,������
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gfd=""; //��¹�����
var gcnt="";
var g_fdcode=""; //��½� ��ȸ�� üũ��.

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();	
}


/******************************************************************************
	Description : ��ȸ�� ��¥���
	//20070516 ������ �߰�
******************************************************************************/
function ln_Date_Cal(){
	
    var frdate = gcem_staxdatfr.text;
    var yyyy = frdate.substring(0,4);
	var mmdd = frdate.substring(4,8);

	if(mmdd=="0101"){
		tempdate = shiftTime(frdate, -1, 0, 0);
		gs_date2 = tempdate.substring(0,4)+"0100";
	}else{
		gs_date2 = yyyy+"0100";
	}
  gs_date3 = shiftTime(frdate, 0, 0, -1); //������ �Ϸ� �� ����
}
/******************************************************************************
	Description : ��ȸ 
******************************************************************************/
function ln_Query(){

  ln_Date_Cal();
	g_fdcode = gclx_sfdcode.BindColVal;
	var str1 = gclx_sfdcode.BindColVal;	//�����ڵ�
	var str2 = gs_date2; //���� ��
	var str3 = gs_date3; //�Ϸ� ����
	var str4 = gcem_staxdatfr.text; //from������
	var str5 = gcem_staxdatto.text; //to������

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030006_s1?v_str1="+str1 
	                                                       +"&v_str2="+str2 
																												 +"&v_str3="+str3 
																												 +"&v_str4="+str4
																												 +"&v_str5="+str5;
	//prompt("",gcds_data1.DataID);
	gcds_data1.Reset();
	
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030006_s2" + "?v_str1="+str1+"&v_str2="+str4+"&v_str3="+str5;
	gcds_data2.Reset();
}
/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save() {
  
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
  
  if(g_fdcode==gclx_sfdcode.bindcolval){
	}else{
		ln_Query();
	}
 
	gcds_tempmst.addrow();
  gcds_tempmst.namevalue(1,"M_FDCODE") = gclx_sfdcode.text;
	gcds_tempmst.namevalue(1,"M_CURDT") = gs_date; 
	gcds_tempmst.namevalue(1,"M_CURTI") = "";
	gcrp_print.Preview();
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Format() {
}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
  gcgd_data1.GridToExcel("�ϰ�ǥ","",2);
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 
	
	gs_date4 = gcurdate.substring(0, 4) + gcurdate.substring(5, 7) + "01"; //�����ϼ���

	//gcem_yyyymmdd.text = gs_date4;
	gcem_staxdatfr.text	= gs_date4;	    //��꼭�Ⱓ from
	gcem_staxdatto.text	= gs_date;			//��꼭�Ⱓ to

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //�����ڵ�

}

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


/***********************************************************************************************
	Description : [�Ϻ�] - �������� ã��
	parameter   : fcod - �����ڵ�, atcod - �����ڵ�, frdt - �˻�����(from), todt - �˻�����(to)
**********************************************************************************************/
function ln_Popup2(fcod,atcod,frdt,todt){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : �Ѱ�������[�Ϻ�] ã��
	parameter   : fcod2 - �����ڵ�, atcod2 - �����ڵ�, frdt2 - �˻�����(from), todt2 - �˻�����(to)
**********************************************************************************************/
function ln_Popup3(fcod2,atcod2,frdt2,todt2){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod2;
	arrParam[1] = atcod2;
	arrParam[2] = frdt2;
	arrParam[3] = todt2;

	strURL = "./dtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : �ܾװ��
******************************************************************************/
function ln_Cal_Janamt(){
  var dbldetot_sum=0; //���� ���� �հ�
	var dblcrtot_sum=0; //�뺯 ���� �հ�
	var dblaf_janamt=0; //���������ܾ�
	var dblcu_janamt=0; //���������ܾ�
	var strGubun ="1";  //�������������ܾ� ���� 1- ����, 
 
  var tempcnt =1;

	gcds_temp01.Clearall();
	
	//����Ÿ�� ����
	ln_SetDataHeader();

  //TOTAL�� ��� �Ұ踦 �ִ´�.

  for(i=1;i<=gcds_data1.countrow;i++){
		gcds_temp01.addrow();
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")=gcds_data1.namevalue(i,"ACTDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT2")=gcds_data1.namevalue(i,"ACTDAT2");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE")=gcds_data1.namevalue(i,"ATCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATKORNAM")=gcds_data1.namevalue(i,"ATKORNAM");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATPRTSEQ")=gcds_data1.namevalue(i,"ATPRTSEQ");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"DETOT")=gcds_data1.namevalue(i,"DETOT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"DECRVAL")=gcds_data1.namevalue(i,"DECRVAL");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"CRCASH")=gcds_data1.namevalue(i,"CRCASH");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"DECASH")=gcds_data1.namevalue(i,"DECASH");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"CRDEVAL")=gcds_data1.namevalue(i,"CRDEVAL");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"CRTOT")=gcds_data1.namevalue(i,"CRTOT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"CRCASH2")=gcds_data1.namevalue(i,"CRCASH2");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"DECASH2")=gcds_data1.namevalue(i,"DECASH2");
		//gcds_temp01.namevalue(gcds_temp01.rowposition,"TOTAL")=gcds_data1.namevalue(i,"TOTAL");
    
		//���ϼҰ迡�� ��������, �뺯���� ����
		if(gcds_data1.namevalue(i,"ATCODE")=="8888888"){     //���ϼҰ�
			dbldetot_sum = gcds_data1.namevalue(i,"CRCASH2");  //0
			dblcrtot_sum = gcds_data1.namevalue(i,"DECASH2");  //1112600
		}

    //�����ܰ�/�����ܰ��� ���� �ܰ�����
		//���������ܾ� = ���� �����ܾ� + �������� - �뺯����
		if(gcds_data1.namevalue(i,"ATCODE")=="8999999"){
		  if(strGubun=="1"){
				dblaf_janamt = gcds_data1.namevalue(i,"DECASH"); //5256633
				dblcu_janamt = dblaf_janamt + dbldetot_sum - dblcrtot_sum  //4144033
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CRCASH")= dblcu_janamt;
        strGubun="2";
			}else{
				dblcu_janamt = dblaf_janamt + dbldetot_sum - dblcrtot_sum  //4144033
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CRCASH")= dblcu_janamt; //�����ܰ� ����
				gcds_temp01.namevalue(gcds_temp01.rowposition,"DECASH")= dblaf_janamt; //�����ܰ�	�뺯
			}

      //���������ܾ��� �������� ���� �����ܾ����� �����.
			dblaf_janamt = dblcu_janamt; 
			dbldetot_sum=0;
			dblcrtot_sum=0;
			gcds_temp01.namevalue(i,"TOTAL")=gcds_data1.namevalue(i,"TOTAL");
		}
	}

  //2007.05.16 ������ �߰� (��¹����� ��ǥ�Ǽ� �߰�)
	//�������ڿ� ���ϰ��� ��� �� ����.
	for(k=1;k<=gcds_data1.countrow;k++){
	  if(gcds_data1.namevalue(k,"ATCODE")=="8888888"){
			for(j=tempcnt;j<=k+1;j++){
				gcds_temp01.namevalue(j,"TOTAL")=gcds_data1.namevalue(k,"TOTAL");
			}
			tempcnt = j;
		}	
	}
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
******************************************************************************/
function ln_SetDataHeader(){
  var s_temp="";

	if (gcds_temp01.countrow<1){
	      s_temp="";
		    s_temp = "ACTDAT:STRING,ACTDAT2:STRING,ATCODE:STRING,ATKORNAM:STRING,ATPRTSEQ:DECIAML,";
				s_temp+= "DETOT:DECIMAL,DECRVAL:DECIAML,CRCASH:DECIAML,DECASH:DECIMAL,";
				s_temp+= "CRDEVAL:DECIMAL,CRTOT:DECIAML,CRCASH2:DECIAML,DECASH2:DECIMAL,TOTAL:DECIMAL";
		gcds_temp01.SetDataHeader(s_temp);
	}

	if (gcds_tempmst.countrow<1){
	  s_temp="";
		s_temp = "M_FDCODE:STRING,M_CURDT:STRING,M_CURTI:STRING";
		gcds_tempmst.SetDataHeader(s_temp);
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ���� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �հ� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ����Ʈ -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_temp01" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_tempmst" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">
	//txt_fdcode.value = gclx_sfdcode.BindColVal;	
</script>

<script language=JavaScript for="gcem_staxdatfr" event="onKillFocus()">
	//20070516 ������ ����
  //gs_date3 = shiftTime(gcem_staxdatfr.text, 0, 0, -1);
	var frdate = gcem_staxdatfr.text;
  var yyyy = frdate.substring(0,4);
	var mmdd = frdate.substring(4,8);
	if(mmdd=="0101"){
		tempdate = shiftTime(frdate, -1, 0, 0);
		gs_date2 = tempdate.substring(0,4)+"0100";
	}else{
		gs_date2 = yyyy+"0100";
	}
	
	gs_date3 = shiftTime(gcem_staxdatfr.text, 0, 0, -1);
	gs_date4 = gcem_staxdatfr.text;
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row<1){
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
    gcgd_data1.DataID="";
		ln_Cal_Janamt();
		gcgd_data1.DataID = "gcds_temp01";
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row<1) {
		//	alert("�˻��� �����Ͱ� �����ϴ�.");
		ft_cnt1.innerText = "��ǥ���� : " + row;
	}
	else {
		ft_cnt1.innerText = "��ǥ���� : " + gcds_data2.nameValue(gcds_data2.rowposition, "TOTAL")
		+ "  ��ǥ��ȣ : " + gcds_data2.nameValue(gcds_data2.rowposition, "FSNBR1")
		+ " ~ " + gcds_data2.nameValue(gcds_data2.rowposition, "FSNBR2");
	}
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<script language=JavaScript for=gcgd_data1 event=OnDblClick(row,colid)>
	var p_fcod = gclx_sfdcode.BindColVal;//�����ڵ�
	var p_acod = gcds_data1.namevalue(row,"ATCODE");//�����ڵ�
	var p_frdt = gcds_data1.namevalue(row,"ACTDAT");//����1
	var p_todt = gcds_data1.namevalue(row,"ACTDAT");//����2
	ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	//��������[�Ϻ�] Popup
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030006_head.gif"></td>
    <td width="879" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" HEIGHT=47>	
			 <IMG src="../../Common/img/btn/com_b_print.gif"  style="cursor:hand"  onclick="ln_Print()">
			 <IMG src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand"  onclick="ln_Excel()">	
			 <IMG src="../../Common/img/btn/com_b_query.gif"  style="CURSOR: hand" onclick="ln_Query()" > 
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>

<table cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr> 
<!------�����ڵ�------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;�����ڵ�&nbsp;</font></nobr></td>				
					<td width="170px;" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
<!-----ȸ������------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;��&nbsp;��&nbsp;</font></nobr></td>
					<td width="600px" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text'),gs_date3 = shiftTime(gcem_staxdatfr.text, 0, 0, -1),gs_date4 = gcem_staxdatfr.text;" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	            value=true>
							<param name=Format	            value="YYYY/MM/DD">
							<param name=PromptChar	        value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;right:0px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<!-- <td width="100px" class="tab12" bgcolor="#eeeeee"><nobr></font style="position:relative;top:1px;">&nbsp;ȸ������&nbsp;</font></nobr></td>
					<td width="170px;" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:5px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	            value=false>
							<param name=Format	            value="YYYY/MM/DD">
							<param name=PromptChar	        value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;�ϰ�ǥ&nbsp;</font></nobr></td>
					<td width="300px" class="tab23"><nobr>&nbsp;
					<img src="../../common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;left:-5px;cursor:hand" onClick="back()">
					<img src="../../common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;left:-7px;cursor:hand" onClick="forward()"></nobr>
					</td>
					<td width=100%>&nbsp;</td> -->
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2">

      <table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:876" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:875" >
						  <PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle"     VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		    VALUE=" 
							<G>Name='����', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DETOT,	  Name='�հ�' ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
								<C>ID=DECRVAL,	Name='��ü' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center,align=right</C>
								<C>ID=CRCASH,   Name='����' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>  
							</G>	
								<C>ID=ATKORNAM, Name='��������' ,width=255, HeadBgColor=#B9D4DC,HeadAlign=center, align=left</C>
							<G>Name='�뺯', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DECASH,   Name='����' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>  
								<C>ID=CRDEVAL,	Name='��ü' ,width=100,HeadBgColor=#B9D4DC,HeadAlign=center,align=right</C>
								<C>ID=CRTOT,	  Name='�հ�',width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
							</G>
												">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;">��ǥ���� :</font>
						</fieldset>
					</td>
        </tr>
			</table>

    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
  <param NAME="MasterDataID"			VALUE="gcds_tempmst">
	<param NAME="DetailDataID"			VALUE="gcds_temp01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<!--<PARAM NAME="SuppressColumns"        VALUE="1:PAGESKIP,">-->
	<param name="SuppressColumns"	value="1:pageskip,actdat;2:TOTAL">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=439 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=19 ,right=1860 ,bottom=93 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=11 ,right=1852 ,bottom=90 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='Page :#p of #t' ,left=2384 ,top=228 ,right=2807 ,bottom=280 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=238 ,top=437 ,right=2810 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=868 ,top=378 ,right=1164 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1889 ,top=381 ,right=2180 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�뺯' ,left=1889 ,top=296 ,right=2799 ,bottom=362 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=2508 ,top=381 ,right=2799 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=550 ,top=373 ,right=550 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=368 ,right=1172 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=860 ,top=373 ,right=860 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1879 ,top=368 ,right=2810 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�հ�' ,left=246 ,top=381 ,right=540 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1172 ,top=286 ,right=1172 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1879 ,top=286 ,right=1879 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ü' ,left=2199 ,top=381 ,right=2490 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=238 ,top=283 ,right=238 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2191 ,top=373 ,right=2191 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=286 ,right=2810 ,bottom=286 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=352 ,top=296 ,right=1093 ,bottom=362 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ü' ,left=558 ,top=381 ,right=849 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� : ' ,left=233 ,top=228 ,right=347 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ACTDAT', left=860, top=116, right=2003, bottom=164 ,mask='( XXXX��XX��XX�� ���� )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��   ��   ǥ' ,left=1021 ,top=19 ,right=1844 ,bottom=82 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='M_FDCODE', left=349, top=228, right=826, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2500 ,top=373 ,right=2500 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='M_CURDT', left=2617, top=177, right=2807, bottom=225, align='right' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��������' ,left=1207 ,top=294 ,right=1831 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� : ' ,left=2447 ,top=177 ,right=2619 ,bottom=225 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2500 ,top=0 ,right=2500 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2191 ,top=0 ,right=2191 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1172 ,top=0 ,right=1172 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=550 ,top=0 ,right=550 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=860 ,top=3 ,right=860 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CRCASH', left=868, top=3, right=1164, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DECASH', left=1889, top=3, right=2180, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=246, top=0, right=540, bottom=48, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DECRVAL', left=558, top=0, right=849, bottom=48, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=238 ,top=0 ,right=238 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1879 ,top=0 ,right=1879 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=53 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='CRDEVAL', left=2199, top=3, right=2490, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRTOT', left=2508, top=0, right=2799, bottom=48, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(ATCODE,\'8888888\',\'                   ��     ��    ��    ��\',\'8999999\',\'                   �����ܰ�/�����ܰ�\',ATKORNAM)}', left=1180, top=5, right=1839, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=47 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=238 ,top=48 ,right=2810 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=0 ,right=238 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ�ż�:' ,left=246 ,top=3 ,right=450 ,bottom=48 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TOTAL', left=450, top=3, right=661, bottom=48, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1878 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2439 ,top=3 ,right=2818 ,bottom=85</I>
	<L> left=238 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
