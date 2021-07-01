<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	������������
+ ���α׷� ID	: bm010i.jsp
+ �� �� �� ��	: ��ȸ|���|����|
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: bm010i_s01,bm010i_t01,bm010i_chk_s01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<Script language="javascript" src="../common/include/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
  var gs_date = gn_Replace(gcurdate,"/");
	var gdataset = "";

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		ln_Before();            //�ʱ�ȭ �Լ�

		var sdata = "/services/servlet/sales.bm.bm010i_s01"
							+ "?v_str1=GG"
							+ "&v_str2="
							+ "&v_str3=GG";
							//+ "&v_str4=" + txt_cust_sid.value;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();

	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function ln_Before(){
		//��������fr
		gcds_cu009_fr.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU009&v_str2=Y";
		gcds_cu009_fr.Reset();

		gcds_cu009.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU009&v_str2=Y";
		gcds_cu009.Reset();
   
		//����
		gcds_sy009.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=SY009";
		gcds_sy009.Reset();
    
		//������
		gcds_cu001.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=SY001";
		gcds_cu001.Reset();

		//�������
		gcds_cu004.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU004";
		gcds_cu004.Reset();

		//������
		gcds_rv003.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=RV003&v_str2=Y";
		gcds_rv003.Reset();

		//����
		gcds_cu020.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU020&v_str2=Y";
		gcds_cu020.Reset();
	
		//����
		gcds_sy005.DataID = "/services/servlet/sales.bm.bm_common_s02?v_str1=SY005&v_str2=100";
		gcds_sy005.Reset();
	}


	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query(){
		var sdata = "/services/servlet/sales.bm.bm010i_s01"
							+ "?v_str1=" + gclx_sy005_fr.bindcolval
							+ "&v_str2=" + txt_cust_nm_fr.value
							+ "&v_str3=" + gcem_regi_no_fr.text;
							//+ "&v_str4=" + txt_cust_sid.value;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}


	/******************************************************************************
		Description : �˾�(������������ �˾�)
	******************************************************************************/
	function ln_Pop(){
		var strURL = "bm010i_r.html";
		var strPos = "dialogWidth:515px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value  = firstList[0]; //CUST_SID
		txt_sy005.value     = firstList[1]; //��������
		txt_work_no.value   = firstList[2]; //�ǹ���ȣ
		txt_nm.value        = firstList[3]; //�̸�
		txt_regi_no.value   = firstList[4]; //�ֹ�/���ǹ�ȣ
		txt_birthday.value  = firstList[5]; //�������
		txt_sy009.value     = firstList[6]; //����
		txt_cu001.value     = firstList[7]; //������
		txt_cu004.value     = firstList[8]; //�������
		txt_rv003.value     = firstList[9]; //������
		txt_last_nm.value   = firstList[10];//������
		txt_first_nm.value  = firstList[11];//��������
		txt_czipcd.value    = firstList[12];//�����ȣ
		txt_cu020.value     = firstList[13];//����
		txt_address1.value  = firstList[14];//�ּ�1
		txt_address2.value  = firstList[15];//�ּ�2
		txt_tel_no.value    = firstList[16];//������ȭ
		txt_mobile_no.value = firstList[17];//�ڵ���
		txt_company_nm.value= firstList[18];//�����
		txt_positions.value = firstList[19];//����
		txt_gu_neme.value   = firstList[20];//����
		txt_nation_cd.value = firstList[21];//����

		ln_AddDetail();
	}


	/******************************************************************************
		Description : ���
	******************************************************************************/
	function ln_Add(){
		//var row = gcds_data.rowposition;
		//if (row<1){alert("��ȸ�� ����ϼ���");return;}

    //ln_Query();
    ln_Pop();
    //ln_AddDetail();
	}
	/******************************************************************************
		Description : ���(����)
	******************************************************************************/
	function ln_AddDetail(){
		//gcds_data.ClearData();
		gcds_data.addrow();
		gcds_data.namevalue(gcds_data.rowposition,"CUST_SID")        =  txt_cust_sid.value;//KEY
		gcds_data.namevalue(gcds_data.rowposition,"COUNTRY_GU")      =  txt_sy005.value;//��������
		gcds_data.namevalue(gcds_data.rowposition,"WORK_NO")         =  txt_work_no.value;//�ǹ���ȣ
		gcds_data.namevalue(gcds_data.rowposition,"CUST_NM")         =  txt_nm.value;////�̸�
		gcds_data.namevalue(gcds_data.rowposition,"MANAGE_NO")       =  txt_regi_no.value;//�ֹ�/���ǹ�ȣ
		gcds_data.namevalue(gcds_data.rowposition,"BIRTHDAY")        =  txt_birthday.value;//�������
		gcds_data.namevalue(gcds_data.rowposition,"SEX")             =  txt_sy009.value;//����
		gcds_data.namevalue(gcds_data.rowposition,"CUST_GU")         =  txt_cu001.value;//������
		gcds_data.namevalue(gcds_data.rowposition,"SAUP_GU")         =  txt_cu004.value;//�������
		gcds_data.namevalue(gcds_data.rowposition,"CUST_TYPE")       =  txt_rv003.value;//������
		gcds_data.namevalue(gcds_data.rowposition,"LAST_NM")         =  txt_last_nm.value;//������
		gcds_data.namevalue(gcds_data.rowposition,"FIRST_NM")        =  txt_first_nm.value;//��������
		gcds_data.namevalue(gcds_data.rowposition,"ZIP_CD")          =  txt_czipcd.value;//�����ȣ
		gcds_data.namevalue(gcds_data.rowposition,"ZIP_NAME")        =  txt_cu020.value;//����
		gcds_data.namevalue(gcds_data.rowposition,"ADDRESS1")        =  txt_address1.value;//�ּ�1
		gcds_data.namevalue(gcds_data.rowposition,"ADDRESS2")        =  txt_address2.value;//�ּ�2
		gcds_data.namevalue(gcds_data.rowposition,"TEL_NO")          =  txt_tel_no.value;//������ȭ
		gcds_data.namevalue(gcds_data.rowposition,"MOBILE_NO")       =  txt_mobile_no.value;//�ڵ���
		gcds_data.namevalue(gcds_data.rowposition,"COMPANY_NM")      =  txt_company_nm.value;//�����
		gcds_data.namevalue(gcds_data.rowposition,"POSITIONS")       =  txt_positions.value;//����
		gcds_data.namevalue(gcds_data.rowposition,"COUNTRY_GU_NAME") =  txt_gu_neme.value;//����
		gcds_data.namevalue(gcds_data.rowposition,"NATION_CD")       =  txt_nation_cd.value;//����
		gcds_data.namevalue(gcds_data.rowposition,"I_EMPNO")         =  gusrid;
		gcds_data.namevalue(gcds_data.rowposition,"U_EMPNO")         =  gusrid;
	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

    gctr_data.KeyValue = "bm010i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm010i_t01";
    //prompt("",gcds_data.text);
		gctr_data.post();

		//ln_Query();
	}

/******************************************************************************
	Description : �ּ� ��ȸ
******************************************************************************/
function ln_Popup(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_czipcd.text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		txt_address1.value = val;
	}
}

	/******************************************************************************
		Description : �Ҽӻ�
	******************************************************************************/
	function ln_SrhCust(){
		var strURL   = "../common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_VEND_SID.text = firstList[0];
		gcem_vend_nm.text = firstList[1];
	} 

	/******************************************************************************
		Description : ���δ�ȸ��
	******************************************************************************/
	function ln_SrhCust2(){
		var strURL   = "../common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_REAL_VEND.text = firstList[0];
		gcem_vend_nm2.text = firstList[1];
	} 

	/******************************************************************************
		Description : �Ҽ���
	******************************************************************************/
	function ln_SrhTeam(){
		var strURL   = "../common/html/Company_Team_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

		gcem_team_cd.text = firstList[0];
		gcem_team_nm.text = firstList[1];
	} 

	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_VEND_SID.text == "") {
			alert("�Ҽӻ縦 �Է��ϼž� �մϴ�.");
			//gcem_VEND_SID.focus();
			return false;
		} 
/*		
		if (gcem_team_cd.text.text = null || gcem_team_cd.text == "") {
			alert("�Ҽ����� �Է��ϼž� �մϴ�.");
			//gcem_team_cd.focus();
			return false;
		}

		if (txt_work_place.value == "") {
			alert("�ٹ���Ҹ� �Է��ϼž� �մϴ�.");
			//txt_work_place.focus();
			return false;
		}

		if (gcem_order_date.text == "" ) {
			alert("�������� �Է��ϼž� �մϴ�.");
			//gcem_order_date.focus();
			return false;
		}

		if (gcem_order_date.text.length < 8) {
			alert("�������� 8�ڸ� �̻��̾��մϴ�");
			//gcem_order_date.focus();
			return false;
		}
*/		
		//Ű���ߺ�üũ
		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="1"){
				gcds_chk.DataID = "/services/servlet/sales.bm.bm010i_chk_s01?v_str1="+txt_cust_sid.value;
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"CUST_SID") != 0){
					alert("������ ���̵� �ֽ��ϴ�.Ȯ���� �Է��ϼ���");
					gcds_data.namevalue(row,"CUST_SID") = "";
					//gcem_lineno.focus();
					return;
				}				
		}

		return true;
	}
	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu009_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu009 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_sy009 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu001 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rv003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_sy005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

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
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	gn_LoadStart();
/*
	if (gcds_data.countrow>0){
		if (gcds_data.namevalue(1,"file_nm")=="") {
			file_nm.src="/services/Sales/images/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(1,"CUST_SID");
			file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1; //Ȯ���� �����Ұ�
			
		}
	} else {
		if (row <1) {
			file_nm.src="/services/Sales/images/00000.gif";
			alert("�˻��� �����Ͱ� �����ϴ�.");
		}		
	}
*/
</script>

<!-- �����϶� ���� ���������� -->
<script language=javascript for=gcds_data event=OnRowPosChanged(row)>
/*
	if (gcds_data.namevalue(row,"file_nm")=="") {
		file_nm.src="services/Sales/images/00000.gif;
	} else {
		var str1 = gcds_data.namevalue(row,"empno");
		file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1;//Ȯ���� �����Ұ�.
	}
*/
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript" for="gcds_sy009" event="onloadCompleted(row,colid)">
	gcds_sy009.deleterow(2);
</script>

<script language="javascript" for="gcds_cu001" event="onloadCompleted(row,colid)">
	gcds_cu001.deleterow(2);
	gcds_cu001.deleterow(2);
</script>

<script language="javascript" for="gcds_cu004" event="onloadCompleted(row,colid)">
	gcds_cu004.deleterow(3);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
</script>


</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<input id="txt_cust_sid" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_sy005" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_work_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_regi_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_birthday" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_sy009" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu001" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu004" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_rv003" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_last_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_first_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_czipcd" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_cu020" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_address1" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_address2" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_tel_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_mobile_no" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_company_nm" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_positions" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_gu_neme" type="hidden" class="txt_a01"  style="width:70px;"> 
<input id="txt_nation_cd" type="hidden" class="txt_a01"  style="width:70px;">



<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/plus.gif"	style="cursor:hand" align=absmiddle onClick="ln_Add()">
      <img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">��������</td>
					<td class="tab_b0100" style='width:180px'>
						<comment id="__NSID__"><OBJECT id=gclx_sy005_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu009_fr">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>	
					<td class="tab_a0100">����</td>
					<td class="tab_b0100">
            <input id="txt_cust_nm_fr" type="text" class="txt_a01"  style="width:120px;"  onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);"> 				
					</td>	
					<td class="tab_a0100">�ֹ�/���ǹ�ȣ</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:130px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:120px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <!-- <td colspan=2>  -->
    <td>
      <table width="395" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:385px;height:430px;" viewastext>
							<param name="DataID"				value="gcds_data">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'			  	ID={CURROW} 	     HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center show=false</F>
								<C> Name='�Ҽ���'		    ID=TEAM_CD			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�ҼӸ�'		    ID=DETAIL_NM		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='��SID'		  ID=CUST_SID			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='����'		      ID=CUST_NM		 	   HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center sort=true</C> 
								<C> Name='(�ֹ�/����)'	ID=MANAGE_NO		   HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center mask='XXXXXX-XXXXXXX'</C> 
								<C> Name='����'		      ID=SEX			       HeadAlign=Center HeadBgColor=#EEEEEE Width=35	align=center editstyle='lookup' data='gcds_sy009:DETAIL:DETAIL_NM'</C> 
								<C> Name='����'		      ID=SEX_NAME			   HeadAlign=Center HeadBgColor=#EEEEEE Width=35	align=center show=false</C> 
								<C> Name='������'		    ID=LAST_NM			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�����̸�'		  ID=FIRST_NM			   HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=left </C> 
								<C> Name='�ǹ���ȣ'		  ID=WORK_NO			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�������'		  ID=BIRTHDAY			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������'		  ID=CUST_GU			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������(��)'	ID=SAUP_GU_NAME	   HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center show=false</C> 
								<C> Name='�ֹι�ȣ'		  ID=REGI_NO			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='����'		      ID=COUNTRY_GU		   HeadAlign=Center HeadBgColor=#EEEEEE Width=45	align=center show=true editstyle='lookup' data='gcds_cu009:DETAIL:DETAIL_NM'</C> 
								<C> Name='�������'		  ID=SAUP_GU			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�������(��)'	ID=SAUP_GU_NAME2	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������'		  ID=CUST_TYPE	  	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������(��)'	ID=CUST_TYPE_NAME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�����ȣ'		  ID=ZIP_CD		    	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='����'		      ID=ZIP_NAME			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�ּ�1'		    ID=ADDRESS1		  	 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�ּ�2'		    ID=ADDRESS2		     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������ȭ'		  ID=TEL_NO			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true</C> 
								<C> Name='�ڵ���'		    ID=MOBILE_NO			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center </C> 
								<C> Name='�����'		    ID=COMPANY_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='����'		      ID=POSITIONS			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='����(��)'		  ID=COUNTRY_GU_NAME HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C>								
								<C> Name='����'		    ID=NATION_CD			   HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center editstyle='lookup' data='gcds_sy005:DETAIL:DETAIL_NM'</C> 
								<C> Name='����(��)'		ID=NATION_NAME		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�Ҽӻ�'		  ID=VEND_SID			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�Ҽӻ�(��)' ID=VEND_NM			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='��λ�'		  ID=REAL_VEND			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='��λ��' ID=VEND_NM2			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='������'		  ID=ORDER_DATE			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�ٹ����'		ID=WORK_PLACE			   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�Է���'		  ID=I_EMPNO			     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								<C> Name='�Է�����'	  ID=I_DATE			       HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:386px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:482px;'>
		    <tr>
				  <!-- <td class="tab_b0100" style='width:100px;' rowspan=4 align=center>����</td> -->
				  <td class="tab_b0100" style='width:100px;' rowspan=4 align=center>
					<!-- -------------------------------------- -->
									<!-- <input type="text" class="txt_a01" id=txt_file name="txt_file" readonly style="width:100px;top:-3px;">  -->
<!-- 									<comment id="__NSID__">
										<object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:8px;width:80;height:20;top:2px">
											<param name="Text"		value="ã�ƺ���">
											<param name="Enable"  value="true">
										</object>
									</comment><script>__ws__(__NSID__);</script>	 -->
									<!-- <input type=image id="file_nm" NAME="file_nm" src="../../person/html/photo/00000.gif" style="width:60px;height:40px;"> -->
									<input type=image id="file_nm" NAME="file_nm" src="/services/Sales/images/00000.gif" style="width:98px;height:104px;">
          <!-- -------------------------------------- -->
					</td>
					<td class="tab_a0101">��������</td>
					<td class="tab_b0001" colspan=3>
						<comment id="__NSID__"><OBJECT id=gclx_sy005 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:0px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu009">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>		
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�ǹ���ȣ</td>
					<td class="tab_b0001" colspan=3>
						<fieldset class=field_01 style="width:150px;">
						<comment id="__NSID__"><OBJECT id=gcem_work_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:145px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�ѱۼ���</td>
					<td class="tab_b0101">
            <input id="txt_cust_nm" type="text" class="txt_a01"  style="width:70px;top:0px" disabled> 
					</td>	
					<td class="tab_a0101">�ֹ�/���ǹ�ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:87px;top:0px">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#############">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>				
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0100">�������</td>
					<td class="tab_b0000" colspan=3>
						<fieldset class=field_01 style="width:70px;top:0px">
						<comment id="__NSID__"><OBJECT id=gcem_birthday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:67px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="0000/00/00">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
			</table><BR>		
			<table class="tab_b1111" border="0" cellpadding="0" cellspacing="0" style='width:482px;'>
		    <tr>
					<td class="tab_a0101">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0101">
						<comment id="__NSID__"><OBJECT id=gclx_sy009 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_sy009">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>	
					<td class="tab_a0101">������</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_cu001 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu001">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>		
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�������</td>
					<td class="tab_b0101">
						<comment id="__NSID__"><OBJECT id=gclx_cu004 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu004">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>				
					</td>		
					<td class="tab_a0101">������</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_rv003 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_rv003">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>			
					</td>						
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0101">
            <input id="txt_last_nm" type="text" class="txt_a01"  style="width:100px;top:-1px" disabled>
					</td>		
					<td class="tab_a0101">�����̸�</td>
					<td class="tab_b0001">
            <input id="txt_first_nm" type="text" class="txt_a01"  style="width:100px;top:-1px" disabled>
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">�����ȣ</td>
					<td class="tab_b0101">
					    <fieldset class=field_01 style="width:55px;top:-1px">
							<comment id="__NSID__"><OBJECT id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  class="gcem_01"
								style="width:47px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=false>
									<param name=Format	      value="000-000">
									<param name=Enable	      value="false">
									<param name=PromptChar	  value="_">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							</fieldset>
					</td>		
					<td class="tab_a0101">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_cu020 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value="gcds_cu020">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>				
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;&nbsp;&nbsp;��1</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_address1" type="text" class="txt_a01"  style="width:337px;top:-1px;" disabled>				
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;&nbsp;&nbsp;��2</td>
					<td class="tab_b0001" colspan=3>
            <input id="txt_address2" type="text" class="txt_a01"  style="width:337px;top:-1px;" disabled>					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">������ȭ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;">
						<comment id="__NSID__"><OBJECT id=gcem_tel_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:110px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
					</td>		
					<td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:120px;top:0px;">
						<comment id="__NSID__"><OBJECT id=gcem_mobile_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:110px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0101">
            <input id="txt_company_nm" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>						
					</td>		
					<td class="tab_a0101">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0001">
            <input id="txt_positions" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>	
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0101">
            <input id="txt_country_gu_neme" type="text" class="txt_a01"  style="width:120px;top:0px;" disabled>						
					</td>		
					<td class="tab_a0101">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_nation_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:-1px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value="gcds_sy005">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>			
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0101">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<comment id="__NSID__"><OBJECT id=gcem_VEND_SID classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px;" onclick="ln_SrhCust();">
					</td>		
					<td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;top:-1px;">
						<comment id="__NSID__"><OBJECT id=gcem_team_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<comment id="__NSID__"><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px" onclick="ln_SrhTeam();">
					</td>	
				</tr>
		    <tr>
				  <td class="tab_a0101">�ٹ����</td>
					<td class="tab_b0101">
            <input id="txt_work_place" type="text" class="txt_a01"  style="width:120px;top:0px;">	
					</td>		
					<td class="tab_a0101">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_order_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:80px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
 		    <tr>
				  <td class="tab_a0100">���δ�ȸ��</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:150px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:140px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=GeneralEdit   value="true">
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<comment id="__NSID__"><OBJECT id=gcem_REAL_VEND classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;top:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Visible   value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:1px;" onclick="ln_SrhCust2();">
					</td>
				</tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=COUNTRY_GU   Ctrl=gclx_sy005	    Param=Bindcolval</C>
		<C>Col=WORK_NO      Ctrl=gcem_work_no	  Param=Text</C>
		<C>Col=CUST_NM      Ctrl=txt_cust_nm	  Param=Value</C>
		<C>Col=MANAGE_NO      Ctrl=gcem_regi_no	  Param=Text</C>
		<C>Col=BIRTHDAY     Ctrl=gcem_birthday	Param=Text</C>
		<C>Col=SEX          Ctrl=gclx_sy009	    Param=Bindcolval</C>
		<C>Col=CUST_GU      Ctrl=gclx_cu001	    Param=Bindcolval</C>
		<C>Col=SAUP_GU      Ctrl=gclx_cu004	    Param=Bindcolval</C>
		<C>Col=CUST_TYPE    Ctrl=gclx_rv003	    Param=Bindcolval</C>
		<C>Col=LAST_NM      Ctrl=txt_last_nm	  Param=Value</C>
		<C>Col=FIRST_NM     Ctrl=txt_first_nm	  Param=Value</C>
		<C>Col=ZIP_CD       Ctrl=gcem_czipcd	  Param=Text</C>
		<C>Col=ZIP_NAME     Ctrl=gclx_cu020     Param=Bindcolval</C>
		<C>Col=ADDRESS1     Ctrl=txt_address1	  Param=Value</C>
		<C>Col=ADDRESS2     Ctrl=txt_address2	  Param=Value</C>
		<C>Col=TEL_NO       Ctrl=gcem_tel_no	  Param=Text</C>
		<C>Col=MOBILE_NO    Ctrl=gcem_mobile_no	Param=Text</C>
		<C>Col=COMPANY_NM   Ctrl=txt_company_nm	Param=Value</C>
		<C>Col=POSITIONS    Ctrl=txt_positions	Param=Value</C>
		<C>Col=COUNTRY_GU_NAME   Ctrl=txt_country_gu_neme	 Param=Value</C>
		<C>Col=NATION_CD    Ctrl=gclx_nation_cd	Param=Bindcolval</C>
		<C>Col=VEND_SID      Ctrl=gcem_VEND_SID	  Param=Text</C>
		<C>Col=VEND_NM      Ctrl=gcem_vend_nm	  Param=Text</C>
		<C>Col=REAL_VEND      Ctrl=gcem_REAL_VEND	  Param=Text</C>
		<C>Col=VEND_NM2      Ctrl=gcem_vend_nm2	  Param=Text</C>
		<C>Col=TEAM_CD      Ctrl=gcem_team_cd	  Param=Text</C>
		<C>Col=WORK_PLACE   Ctrl=txt_work_place	Param=Value</C>
		<C>Col=ORDER_DATE   Ctrl=gcem_order_date  Param=Text</C>
		<C>Col=DETAIL_NM   Ctrl=gcem_team_nm  Param=Text</C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
