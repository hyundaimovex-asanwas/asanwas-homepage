<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �������� - ���޸��� 
+ ���α׷� ID	:  P030020.html
+ �� �� �� ��	:  ����û�� �����ϱ� ���� ���޸��� �ڷḦ �����ͷ� ���� �����Ѵ�.
                       ������ ���� ���̺� ����ǰ�, �� �����ͷ� ���� �ؽ�Ʈ ������ �����ϱ� ���� �����ޱ� �Ѵ�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 p030020_s1
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>����û ���� �ڷ� �����ޱ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

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

get_cookdata();

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

gs_date2 = gcurdate.substring(0,4);

var x = 1;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_saccyy.text    = '201012';	//�⵵

	gcem_vendnm0.text="����ƻ��ֽ�ȸ��";

	gcem_vendid0.text="2218113834";

}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	var str1 = gcem_saccyy.text;					//�⵵

	if(gcem_saccyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	}

	gcds_data.DataID = "/servlet/Payroll.p030020_s11?v_str1="+str1; 
	//prompt(this, gcds_data.DataID);
	gcds_data.Reset(); 

}



/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Create(){

	ln_SetDataHeaderClearAll();

	ln_SetDataHeader();

	gcds_ihead.Addrow();

	if(gcds_ihead.IsUpdated) {	

		if (confirm("���� �Ͻðڽ��ϱ�?")){	

				//prompt(this, gcds_ihead.dataID);
				//prompt(this, gcds_ihead.text);

				gctr_data.KeyValue = "p030020_t11(I:USER=gcds_ihead)";

				gctr_data.action = "/servlet/Payroll.p030020_t11";

				gctr_data.Parameters = "v_str1=2010,v_str2="+gs_date;

				gctr_data.post();

		}

	}else{

		alert("�����Ͻ� ������ �����ϴ�.");

	}

	ln_Display();

}


function ln_SetDataHeaderClearAll(){

	gcds_ihead.ClearAll();

}

/******************************************************************************
	Description :  Head ����
******************************************************************************/
function ln_SetDataHeader(){

	var s_tmp1 = "RECORD:STRING,DATA:STRING,SEMU:STRING,"
					    + "SUBMITDT:STRING,SUBMITGB:STRING,"
					    + "SEMUNO:STRING,HOMETAXID:STRING,"
						+ "SEMUPGM:STRING,BIZNO:STRING,BIZNM:STRING,"
						+ "CHARGEDEPT:STRING,CHARGENM:STRING,"
						+ "CHARGETEL:STRING,DUTYCNT:STRING,"
						+ "KORCD:STRING,SPACE:STRING";

	gcds_ihead.SetDataHeader(s_tmp1);
	
}

/******************************************************************************
	Description : �����ޱ�
******************************************************************************/

function ln_Download(){

  var strfilenm = "H2218113.834";

	if (gcds_data99.countrow<1) {

		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");

	} else { 

		gcgd_data01.ExportFileEx(strfilenm,true,1,false);

 	}

}


/******************************************************************************
	Description : �ڷ� �����ޱ� ȭ�� display
******************************************************************************/
function ln_Display(){

		gcds_down_a.DataID = "/servlet/Payroll.p030020_s12?v_str1=2010";
		gcds_down_a.Reset();

		gcds_down_b.DataID = "/servlet/Payroll.p030020_s13?v_str1=2010";	
		gcds_down_b.Reset();

		gcds_down_c.DataID = "/servlet/Payroll.p030020_s14?v_str1=2010";	
		gcds_down_c.Reset();

		gcds_down_d.DataID = "/servlet/Payroll.p030020_s15?v_str1=2010";	
		gcds_down_d.Reset();

  
		gcds_data99.clearAll();

		var s_temp = "DISKET:STRING";

		gcds_data99.SetDataHeader(s_temp);

	  for(i=1;i<=gcds_down_a.countrow;i++){
		ln_Forward_Batch_A(i);
	  }


	  for(i=1;i<=gcds_down_b.countrow;i++){
		ln_Forward_Batch_B(i);
	  }
			var s = 1;
			var t = 1;

		for(i=1;i<=gcds_down_c.countrow;i++){

			var juminbunho = gcds_down_c.namevalue(i,"JUMINNO");

			if(juminbunho == gcds_down_c.namevalue(i+1,"JUMINNO")){

				ln_Forward_Batch_C(i,s,t);

				t++;

			}else{

				ln_Forward_Batch_C(i,s,t);
				ln_Forward_Batch_ddd(i);		
				s++;
				t = 1;				
			}

		}
}


/******************************************************************************
	Description : ddd ���ڵ�
******************************************************************************/
function ln_Forward_Batch_ddd(i){

			var seq = 1;

			for(j=1;j<=gcds_down_d.countrow;j++){

				if(gcds_down_c.namevalue(i,"JUMINNO") == gcds_down_d.namevalue(j,"JUMINNO") ){

				ln_Forward_Batch_D(j, seq, x);

				seq++;

				}
				
			}

				x++;			
			
}

/******************************************************************************
	Description : A ���ڵ�
******************************************************************************/
function ln_Forward_Batch_A(i){

			var DISKET = "";

			DISKET+=strStr(gcds_down_a.namevalue(i,"RECORD")  ,"1");				//���ڵ屸��
			DISKET+=strStr(gcds_down_a.namevalue(i,"DATA")  ,"2");					//��αݸ���
//			DISKET+=strStr(gcds_down_a.namevalue(i,"SEMU")  ,"3");					//�������ڵ�
			DISKET+="227";
			DISKET+=strStr(gcds_down_a.namevalue(i,"SUBMITDT") ,"8");				//��������
			DISKET+=strStr(gcds_down_a.namevalue(i,"SUBMITGB") ,"1");			//�����ڱ���
			DISKET+=strStr(gcds_down_a.namevalue(i,"SEMUNO") ,"6");				//�����븮�ΰ�����ȣ
			DISKET+=strStr(gcds_down_a.namevalue(i,"HOMETAXID"),"20");			//Ȩ�ý�ID
			DISKET+=strStr(gcds_down_a.namevalue(i,"SEMUPGM")  ,"4");			//�������α׷��ڵ�
			DISKET+=strStr(gcds_down_a.namevalue(i,"BIZNO")  ,"10");				//����ڵ�Ϲ�ȣ
			DISKET+=strStr(gcds_down_a.namevalue(i,"BIZNM")  ,"40");				//���θ�
			DISKET+=strStr(gcds_down_a.namevalue(i,"CHARGEDEPT") ,"30");		//����ںμ�
			DISKET+=strStr(gcds_down_a.namevalue(i,"CHARGENM") ,"30");			//����ڼ���
			DISKET+=strStr(gcds_down_a.namevalue(i,"CHARGETEL"),"15");			//�������ȭ��ȣ
			DISKET+=strStr(gcds_down_a.namevalue(i,"DUTYCNT")  ,"5");				//�Ű��ǹ��ڼ�
			DISKET+=strStr(gcds_down_a.namevalue(i,"KORCD")  ,"3");				//����ѱ��ڵ�
			DISKET+=strStr(gcds_down_a.namevalue(i,"SPACE")  ,"2");					//����

			gcds_data99.addrow();

			gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;

}


/******************************************************************************
	Description : B ���ڵ�
******************************************************************************/
function ln_Forward_Batch_B(i){

			var DISKET = "";
			  
			DISKET+=strStr(gcds_down_b.namevalue(i,"RECORD"),"1");					//���ڵ屸��
			DISKET+=strStr(gcds_down_b.namevalue(i,"DATA"),"2");						//��αݸ���
//			DISKET+=strStr(gcds_down_b.namevalue(i,"SEMU"),"3");						//�������ڵ�
			DISKET+="227";
			DISKET+=strStr(gcds_down_b.namevalue(i,"SEQ"),"6");						//�Ϸù�ȣ
			DISKET+=strStr(gcds_down_b.namevalue(i,"BIZNO"),"10");					//����ڵ�Ϲ�ȣ
			DISKET+=strStr(gcds_down_b.namevalue(i,"BIZNM"),"40");					//���θ�
		
			DISKET+=intStr(String(gcds_down_c.countrow), "7");		//C���ڵ��
			DISKET+=intStr(String(gcds_down_d.countrow),"7");		//D���ڵ��

			DISKET+=intStr(gcds_down_b.namevalue(i,"GIBUAMTSUM"),"13");		//��αݾ��Ѱ�
			DISKET+=intStr(gcds_down_b.namevalue(i,"DEDAMTSUM"),"13");		//�������ݾ��Ѱ�
			DISKET+=intStr(gcds_down_b.namevalue(i,"TERMCODE"),"1");				//������Ⱓ,
			DISKET+=strStr(gcds_down_b.namevalue(i,"SPACE"),"77");					//����

			gcds_data99.addrow();

			gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;

}


/******************************************************************************
	Description : C ���ڵ�
******************************************************************************/

function ln_Forward_Batch_C(i,s,t){

			var DISKET = "";

			DISKET+=strStr(gcds_down_c.namevalue(i,"RECORD"),"1");					//���ڵ屸��
			DISKET+=strStr(gcds_down_c.namevalue(i,"DATA"),"2");						//�ڷᱸ��
//			DISKET+=strStr(gcds_down_c.namevalue(i,"SEMU"),"3");						//�������ڵ�
			DISKET+="227";
			DISKET+=intStr(String(s),"6");															//�ҵ����Ϸù�ȣ

			DISKET+=strStr(gcds_down_c.namevalue(i,"BIZNO"),"10");					//����ڵ�Ϲ�ȣ
			DISKET+=strStr(gcds_down_c.namevalue(i,"JUMINNO"),"13");				//�ҵ����ֹι�ȣ
			DISKET+=strStr(gcds_down_c.namevalue(i,"FOREIGNER"),"1");			//���ܱ��α���
			DISKET+=strStr(gcds_down_c.namevalue(i,"NAME"),"30");					//����
			DISKET+=strStr(gcds_down_c.namevalue(i,"DUDGB"),"2");					//�����ڵ�

			DISKET+=strStr("2010","4");					//��ο���

			DISKET+=intStr(gcds_down_c.namevalue(i,"GIBUAMT"),"13");				//��αݾ�
			DISKET+=intStr(gcds_down_c.namevalue(i,"DEDEDAMT"),"13");			//������������ݾ�
			DISKET+=intStr(gcds_down_c.namevalue(i,"APPLYAMT"),"13");			//�������ݾ�
			DISKET+=intStr(gcds_down_c.namevalue(i,"YEARDEDAMT"),"13");		//�ش�⵵�����ݾ�
			DISKET+=intStr(gcds_down_c.namevalue(i,"EXITAMT"),"13");				//�Ҹ�ݾ�
			DISKET+=intStr(gcds_down_c.namevalue(i,"CARRYAMT"),"13");			//�̿��ݾ�

			DISKET+=intStr(String(t),"5");				//��α��������Ϸ�

			DISKET+=strStr(gcds_down_c.namevalue(i,"SPACE"),"25");					//����

			gcds_data99.addrow();

			gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;




}


/******************************************************************************
	Description : D ���ڵ�
******************************************************************************/

function ln_Forward_Batch_D(i, seq, x){

			var DISKET = "";

			DISKET+=strStr(gcds_down_d.namevalue(i,"RECORD"),"1");						//���ڵ屸��
			DISKET+=strStr(gcds_down_d.namevalue(i,"DATA"),"2");							//�ڷᱸ��
//			DISKET+=strStr(gcds_down_d.namevalue(i,"SEMU"),"3");							//�������ڵ�
			DISKET+="227";

			DISKET+=intStr(String(x),"6");							//�ҵ����Ϸù�ȣ

			DISKET+=strStr(gcds_down_d.namevalue(i,"BIZNO"),"10");						//����ڵ�Ϲ�ȣ
			DISKET+=strStr(gcds_down_d.namevalue(i,"JUMINNO"),"13");					//�ҵ����ֹι�ȣ
			DISKET+=strStr(gcds_down_d.namevalue(i,"DUDGB"),"2");						//�����ڵ�
			DISKET+=strStr(gcds_down_d.namevalue(i,"GIBUBIZNO"),"13");				//���ó�����Ϲ�ȣ
			DISKET+=strStr(gcds_down_d.namevalue(i,"GIBUNM"),"30");					//���ó��ȣ
			DISKET+=strStr(gcds_down_d.namevalue(i,"RELATION"),"1");					//�����ڵ�
			DISKET+=strStr(gcds_down_d.namevalue(i,"FOREIGNER"),"1");				//���ܱ��α���
			DISKET+=strStr(gcds_down_d.namevalue(i,"NAME"),"20");						//����
			DISKET+=strStr(gcds_down_d.namevalue(i,"GIBUZAJUMINNO"),"13");		//������ֹε�Ϲ�ȣ

			if(gcds_down_d.namevalue(i,"GIBUYYCNT") == "0" )
			DISKET+=intStr("1","5");				//������ΰǼ�
			else
			DISKET+=intStr(gcds_down_d.namevalue(i,"GIBUYYCNT"),"5");				//������ΰǼ�

			DISKET+=intStr(gcds_down_d.namevalue(i,"GIBUYYAMT"),"13");				//������αݾ�

			DISKET+=intStr(String(seq),"5");				//��α��������Ϸ�

			DISKET+=strStr(gcds_down_d.namevalue(i,"SPACE"),"42");						//����

			gcds_data99.addrow();

			gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;

}


/******************************************************************************
	Description : ����Ÿ�� ���� ó����.
******************************************************************************/
function strStr(a, b){
  var returnVal = "";
  if(a==null) a = "";
  var alength = calculateBytes(a);
  var tt = calculateBytesStr(a,b);

  if(alength<=b){
    returnVal+=a;
    for(var i=0; i<b-alength; i++){
      returnVal+=" ";
    }
  }else{
    returnVal = tt;
  }
  return returnVal;
}



/******************************************************************************
	Description : ����Ÿ�� ���� 0���� ó����.
******************************************************************************/
function intStr(a, b){

  var returnVal="";
  if(a==null) a="";
  var alength=a.length;

  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";

    }
  }
  returnVal+=a;

  return returnVal;

}


function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}



/******************************************************************************
	Description : ����Ʈ ó�� 
******************************************************************************/
function calculateBytes(szValue){
  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}
function calculateBytesStr(szValue,b){
  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}




/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("���޸��� �����ü ����","",2);

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!--�Է°���  -->
<object  id=gcds_ihead classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<!--�����ޱ� -->
<object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_a classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_b classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_c classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_down_d classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	////document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("������ �߻� �߽��ϴ�!");
	  window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
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
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif">
	<img src="../../Common/img/p030020_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
	<tr><td height=4></td></tr>
</table>

<!-- ���� ====================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:20px;border:0 solid #708090'>
				<tr>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
			</td>
			</tr>
			<tr><!-- ���� ----------------------------------------------------------------------------------------->
				<td style="position:relative;left:6px">
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>

							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ͼӳ⵵</nobr></td>
							<td class="tab23" style="width:60px"><comment id="__NSID__">
								<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:0px;width:50px;height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYYMM">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>							
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��ȣ(���θ�)</nobr></td>
							<td class="tab23" style="width:200px"><comment id="__NSID__">
								<object id=gcem_vendnm0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:200px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=GeneralEdit value="true">
									<param name=Language		value=1>
									<param name=ReadOnly    value=true>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>����ڵ�Ϲ�ȣ</nobr></td>
							<td class="tab10" style="width:100px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendid0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=BackColor     value="#CCCCCC">
									<param name=Format			  value="000-00-00000">
									<param name=PromptChar	  value="_">
									<param name=InheritColor  value=false>
									<param name=ReadOnly      value=true>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>


			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top>
					<comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:220px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name=SortView  value="Left">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='NO'	      ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40	   	align=center		SumBgColor='#C3D0DB' BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C> 
								<C> Name='����'  	ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center		  SumBgColor='#C3D0DB' sort=false  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')} </C>
								<C> Name='����'  	ID=GIVPRCD 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center		  SumBgColor='#C3D0DB' sort=false BgColor={decode(CARDNO,'0000000000000000    ','Orange','')} 
								value={IF (GIVPRCD='1','����',IF (GIVPRCD='2','�����' ,IF (GIVPRCD='3','������' , '')))} </C>
								<C> Name='�����'  	ID=GIVPRNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center		  SumBgColor='#C3D0DB' sort=false  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')} </C>
								<C> Name='�����\\��Ϲ�ȣ'		ID=GIVSAUP	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center		SumBgColor='#C3D0DB' sort=false mask='XXX-XX-XXXXX' BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='��ȣ(���θ�)'		ID=GIVCOMP	HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=center		SumBgColor='#C3D0DB' sort=false  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>								
								<C> Name='����û\\�Ǽ�'			ID=GIVCNT1 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=right		SumText=@sum	SumBgColor='#C3D0DB'  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='����û�ݾ�'		  ID=GIVAMT1		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='�׹���\\�Ǽ�'   	    ID=GIVCNT2		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=right		SumText=@sum	SumBgColor='#C3D0DB'  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>
								<C> Name='�׹��Ǳݾ�'   	    ID=GIVAMT2		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'  BgColor={decode(CARDNO,'0000000000000000    ','Orange','')}</C>

							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 



	<tr>
    <td>
			<table width="867" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:173px;position:relative;left:5px;top:3px">
					<nobr><FONT SIZE="2" COLOR="blue"><B>[�����ޱ�]</B></FONT></nobr></td>
					<td align="right"><nobr>      
						<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand;position:relative;top:5px;right:2px" onclick="ln_Download()">


						<img src="../../Common/img/btn/com_b_create.gif"	  style="cursor:hand;position:relative;top:5px;right:2px" onClick="ln_Create()"> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>

			<table width="867" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td style="position:relative;left:5px;top:3px">
						<comment id="__NSID__">
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data01 style="WIDTH:867px;HEIGHT:200px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data99">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Fillarea"			VALUE="true">
							<param name="ColSelect"		value="false">
							<param name="ColSizing"		value="true">
							<PARAM NAME="Format"			VALUE="  
								<C>ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=850	align=left</C>



							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:867px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
			 



<comment id="__NSID__">



<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px">
</iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
