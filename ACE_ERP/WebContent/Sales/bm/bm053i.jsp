<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>

<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	��ȭ ����
+ ���α׷� ID	: bm052i.jsp
+ �� �� �� ��	: ��ȸ|����|����
+ �� �� �� ��	: KBJ
+ �� �� �� ��	: 
------------------------------------------------------------------------------
������ư : Ŭ�� �� �׸��� �ʱ�ȭ. ���� ���ε��Ͽ� �׸��忡   Display.
-. ��ȭ��Ͼ��ε��ư : ��ȭ��Ͼ��ε� ���̺� ����. ���� ������ �׸��常 �� ��ȸ
-. ����ȭ��ư : ��ȭ����(tel_his) �� ���ε�(telhis_up)���̺� ����ȭ. Telhis_up.up_sid <> 0 �ΰ͸� ����
tel_his.tel_date = telhis_up.up_date
tel_mst.tel_num = telhis_up.tel_num
tel_his.tel_etime = left(telhis_up.end_time, 4)
�� �������� loop����. Match�Ǵ� ������ tel_his�� telhis_up���̺� ����� sid ����. 
Mismatch�׸��� ������ �Ʒ� �׸��忡 display. 
Order by up_sid desc
-. ���� �Ʒ� �׸��� tel_his���� up_sid�� ���� �͸� ��ȸ. 
Order byTelhis_sid desc
-. ������ ��ȭ���� Ŭ�� ���¿��� ��Match����ư���� ������ sid����
//-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
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
			fnInit_tree(tree_idx);	
			ln_Before();            
	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function ln_Before(){

    /**
		gcds_cm002.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CM002";
		gcds_cm002.Reset();
    **/
	}

	/******************************************************************************
		Description : ��ȸ(����)
	******************************************************************************/
	function ln_Query(){
		  
			if(fn_trim(gcem_yymm.text)==""){
				alert("����� Ȯ���Ͻʽÿ�.");
				gcem_yymm.focus();
				return;
			}

			gcds_data_1.ClearAll();
			gcds_data_2.ClearAll();
			gcds_data_3.ClearAll();

			var sdata = "/services/servlet/sales.bm.bm053i_s1"
								+ "?v_str1=" + gcem_yymm.text;//
			gcds_data_1.DataID = sdata; 
			gcds_data_1.Reset();			

			var sdata = "/services/servlet/sales.bm.bm053i_s2"
								+ "?v_str1=" + gcem_yymm.text;//
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();			

			var sdata = "/services/servlet/sales.bm.bm053i_s3"
								+ "?v_str1=" + gcem_yymm.text;//
			gcds_data_3.DataID = sdata; 
			gcds_data_3.Reset();		

			gcgd_disp03.ColumnProp("PARM0", "Value") = "{Currow}";
	}

	/******************************************************************************
		Description : ��ȸ(����)
	******************************************************************************/
	function ln_Query2(){

    /**
		var temp= gcem_telNum.text;
    var chk="";

		temp = temp.replace("-","");
		temp = temp.replace("-","");

		//alert("temp::"+temp);
    //alert(temp.length);
		for (i=0;i<temp.length;i++){
			if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				chk="N";
			}else{
				chk="C";
				break;
			}
		}

		if(chk=="N"){
			//alert("����");
			var str1 = temp;

			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str1=" + str1;//����(��ȭ��ȣ)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();			
		}else{
      //alert("����");
			var str2 = temp;
			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str2=" + str2;//����(����ó)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();
		}	

		**/

	}

	/******************************************************************************
		Description : ���
	******************************************************************************/
	function ln_Add(){ 

      /** 
			ln_Enable("s");

      gcds_data_3.addrow();

			var row = gcds_data_2.rowposition;
			if (row<1) return;

			gcds_data_3.NameValue(gcds_data_3.rowposition,"CUST_SID") = gcds_data_2.NameValue(gcds_data_2.rowposition,"CUST_SID");//����ڹ�ȣ1
      gcds_data_3.NameValue(gcds_data_3.rowposition,"CT") = "c";//�������2
			//�ǹ���ȣ3 //�Է��Ҽ� �ְԸ�.
			gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_SID") = gcds_data_2.NameValue(gcds_data_2.rowposition,"TEL_SID");//4.��ȭ��ȣTEL_SID
			gcem_tel_date.text = gs_date;//5.��ȭ����
			gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_STIME") = "1220";//6.��ȭ���۽ð�(�����)
			gcds_data_3.NameValue(gcds_data_3.rowposition,"TEL_ETIME") = "1220";//7.��ȭ����ð� (�����)
			//8.���ð�.(�����)
			
			//9.���(�����)
			//10.���꿩��
			gcds_data_3.NameValue(gcds_data_3.rowposition,"CAL_YN") = "N";//10.���꿩�� 
			gcds_data_3.NameValue(gcds_data_3.rowposition,"I_EMPNO") = gusrid;//11.�Է��� 
			gcds_data_3.NameValue(gcds_data_3.rowposition,"U_EMPNO") = gusrid;//12.������ 

			**/

	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){

    /**
		if (!gcds_data_3.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

		if (!ln_Valchk()) return;

    gctr_data.KeyValue = "bm052i_t01(I:DATA=gcds_data_3)";
    gctr_data.Action = "/services/servlet/sales.bm.bm052i_t01";
    //prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query2();
    **/
	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Delete(){

	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Excel(){

	}

	/******************************************************************************
		Description : ���(�˾�)
	******************************************************************************/
	function ln_SrhEmpno(){
		/**
		var strURL = "bm051i_r.html";
		var strPos = "dialogWidth:435px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value   = firstList[0]; 
		txt_cdname_fr.value  = firstList[1]; 
		**/
	} 


	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){
    /**
		if (gcem_tel_stime.text == null || gcem_tel_stime.text == "") {
			alert("��ȭ���۽ð��� �ʼ� �Է»����Դϴ�.");
			return false;
		}


    if(gcra_ct.CodeValue=="t" && gcra_cal_yn.CodeValue=="N"){
		   alert("�������϶��� �����Ҽ� �����ϴ�.");
			 return false;
		}

		//Ű���ߺ�üũ
		var row = gcds_data_3.rowposition;
		if(gcds_data_3.sysStatus(row)=="1"){

				gcds_chk.DataID = "/services/servlet/sales.bm.bm052i_chk_s01?v_str1="+gcem_cust_sid.text;
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"CUST_SID") != 0){
					alert("�ߺ��� ����ڹ�ȣ�� �ֽ��ϴ�.Ȯ���� �Է��ϼ���");
					gcds_data_3.namevalue(row,"CUST_SID") = "";
					gcds_data_3.deleterow(row);
					return;
				}				
		}

		return true;

		**/

	}
	
/******************************************************************************
	Description : Enable Format
******************************************************************************/
function ln_Enable(chk){
	  /**
		if (chk == "a") {
			gcem_tel_date.enable=false;
			gcem_tel_stime.enable=false;
			gcem_tel_etime.enable=false;
			gcem_tel_dura.enable=false;
			gcra_cal_yn.enable=false;
		}else if(chk == "s") {
			gcem_tel_date.enable=true;
			gcem_tel_stime.enable=true;
			gcem_tel_etime.enable=true;
			gcem_tel_dura.enable=true;
			gcra_cal_yn.enable=true;
		}
		**/
}


/******************************************************************************
	Description : Excel upload �˾�
******************************************************************************/
function ln_ExcelApply(){
	window.open('../common/html/uploadpage.html','','top=200px,left=300px,resizable=no,width=450,height=58,scrollbars=no');
}

/******************************************************************************
	Description : Excel upload query : ���� ������ DataSet�� import ��
******************************************************************************/
function ln_ExcelApply_Qeury(e){
	gcds_data_3.DataID = "/services/servlet/sales.common.excel_load_sales_tcm090?v_str1="+e;
	//prompt('',gcds_data_3.DataID);
	gcds_data_3.Reset();
}

/******************************************************************************
	Description : Grid�� ������ ����Ÿ�� DB�� Insert ��.
******************************************************************************/
function ln_DBApply(){
  gcds_data_3.UseChangeInfo=false;
	if(!ln_DBApply_Chk()) return;
	
	if (confirm("DB�� �����Ͻðڽ��ϱ�?")){
		gctr_data.KeyValue = "bm053i_t1(I:USER=gcds_data_3)";
		gctr_data.action = "/services/servlet/sales.bm.bm053i_t1?";
		gctr_data.Parameters = "v_str1="+gusrid;
		//prompt('',gcds_data_3.text);
		gctr_data.post();
		gcds_data_3.UseChangeInfo=true;
	}
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
function ln_DBApply_Chk(){
	if(gcds_data_3.countrow<1){
		alert("������ ����Ÿ�� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");
		return false;
	}

  //�� �Էµ� �������� üũ
  gcds_data_chk.DataID = "/services/servlet/sales.bm.bm053i_s4?v_str1="+gcds_data_3.namevalue(1,"PARM1")
											                                      +"&v_str2="+gcds_data_3.namevalue(1,"PARM2")
											                                      +"&v_str3="+gcds_data_3.namevalue(1,"PARM3")
		                                                        +"&v_str4="+gcds_data_3.namevalue(1,"PARM4")
											                                      +"&v_str5="+gcds_data_3.namevalue(1,"PARM5")
		                                                        +"&v_str6="+gcds_data_3.namevalue(1,"PARM6");
		                                                         	                                                                       
	//prompt('',gcds_data_chk.DataID);
	gcds_data_chk.Reset();

	if(gcds_data_chk.countrow>=1){
		alert("�̹� ������ ����Ÿ�Դϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : �ϰ�����ȭ
******************************************************************************/
function ln_SyncA(){
	 _A:
	for(i=1;i<=gcds_data_2.countrow;i++){	
		_B:
		for(j=1;j<=gcds_data_3.countrow;j++){
			 if(gcds_data_2.namevalue(i,"TEL_DATE")==gcds_data_3.namevalue(j,"PARM1")&&    
				  gcds_data_2.namevalue(i,"TEL_NUM")==gcds_data_3.namevalue(j,"PARM3")&&
				  gcds_data_2.namevalue(i,"TEL_ETIME").substring(0,4)==gcds_data_3.namevalue(j,"PARM4").substring(0,4)&&
				  gcds_data_2.namevalue(i,"TEL_DURA")==gcds_data_3.namevalue(j,"PARM5")&&
				  gcds_data_2.namevalue(i,"TEL_FEE")==gcds_data_3.namevalue(j,"PARM6")){
          
					gcds_data_2.namevalue(i,"UP_SID")= gcds_data_3.namevalue(j,"PARM8");     // TELHIS_SID   
				  gcds_data_3.namevalue(j,"PARM7") = gcds_data_2.namevalue(i,"CUST_SID");  // Custsid
					break _B;
			 }
		}
	}
	
	if (confirm(" �ϰ� ����ȭ �Ͻðڽ��ϱ�?")){
		gctr_data.KeyValue = "bm053i_t2(I:USER1=gcds_data_2,I:USER2=gcds_data_3)";
		gctr_data.action = "/services/servlet/sales.bm.bm053i_t2?";
		//prompt('',gcds_data_2.text);
		//prompt('',gcds_data_3.text);
		gctr_data.Parameters = "v_str1="+gusrid;
		gctr_data.post();
	}
	
}
/******************************************************************************
	Description : ����
	              gcds_data_2 : ��ȭ�̷�
								gcds_data_3 : ��ȭ���ε�
******************************************************************************/
function ln_SyncB(){

   var i = gcds_data_2.rowposition;
   var j = gcds_data_3.rowposition;

	 if(gcds_data_2.namevalue(i,"TEL_DATE")==gcds_data_3.namevalue(j,"PARM1")&&    
		  gcds_data_2.namevalue(i,"TEL_NUM")==gcds_data_3.namevalue(j,"PARM3")&&
		  gcds_data_2.namevalue(i,"TEL_ETIME").substring(0,4)==gcds_data_3.namevalue(j,"PARM4").substring(0,4)&&
		  gcds_data_2.namevalue(i,"TEL_DURA")==gcds_data_3.namevalue(j,"PARM5")&&
		  gcds_data_2.namevalue(i,"TEL_FEE")==gcds_data_3.namevalue(j,"PARM6")){
		   
      gcds_data_2.namevalue(i,"UP_SID")= gcds_data_3.namevalue(j,"PARM8");     // TELHIS_SID   
			gcds_data_3.namevalue(j,"PARM7") = gcds_data_2.namevalue(i,"CUST_SID"); // Custsid		
	 }

	 if (confirm(" �Ǻ� ����ȭ �Ͻðڽ��ϱ�?")){
		gctr_data.KeyValue = "bm053i_t2(I:USER1=gcds_data_2,I:USER2=gcds_data_3)";
		gctr_data.action = "/services/servlet/sales.bm.bm053i_t2?";
		gctr_data.Parameters = "v_str1="+gusrid;
		gctr_data.post();
	}


  /*
  _A:
	for(i=1;i<=gcds_data_2.countrow;i++){
		
		_B:
		for(j=1;j<=gcds_data_3.countrow;j++){
			 if(gcds_data_2.namevalue(i,"TEL_DATE")==gcds_data_3.namevalue(j,"PARM1")&&    
				  gcds_data_2.namevalue(i,"TEL_NUM")==gcds_data_3.namevalue(j,"PARM3")&&
				  gcds_data_2.namevalue(i,"TEL_ETIME").substring(0,4)==gcds_data_3.namevalue(j,"PARM4").substring(0,4)&&
				  gcds_data_2.namevalue(i,"TEL_DURA")==gcds_data_3.namevalue(j,"PARM5")&&
				  gcds_data_2.namevalue(i,"TEL_FEE")==gcds_data_3.namevalue(j,"PARM6")){

				  gcds_data_3.namevalue(j,"PARM7") = gcds_data_2.namevalue(i,"CUST_SID");  // Custsid
					gcds_data_2.namevalue(i,"UP_SID")=gcds_data_3.namevalue(j,"PARM8");     // TELHIS_SID   

					break _A;
			 }
		}
	}
	*/
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data_3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_data_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_cm002 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
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
<script language="javascript" for="gcds_data_1" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_1" event="onloadCompleted(row,colid)">
	//gn_LoadComp('1',gcds_data_1.countrow);
	document.all.LowerFrame.style.visibility="hidden";
	eval(ft_cnt1).innerText = "��ȸ�Ǽ� : " + row + " ��";
</script>

<script language="javascript" for="gcds_data_2" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_2" event="onloadCompleted(row,colid)">
	//gn_LoadComp('2',gcds_data_2.countrow);
	document.all.LowerFrame.style.visibility="hidden";
	eval(ft_cnt2).innerText = "��ȸ�Ǽ� : " + row + " ��";
</script>

<script language="javascript" for="gcds_data_3" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_3" event="onloadCompleted(row,colid)">
	//gn_LoadComp('3',gcds_data_3.countrow);
	document.all.LowerFrame.style.visibility="hidden";
	eval(ft_cnt3).innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_disp2 event=OnClick(Row,Colid)>
		/**
		var str1 = gcds_data_2.namevalue(gcds_data_2.rowposition,"CUST_SID");
		var row = gcds_data_3.rowposition;

		gcds_data_3.DataID = "/services/servlet/sales.bm.bm052i_s03?v_str1="+str1;
		gcds_data_3.Reset();

		if(gcds_data_3.countrow<1){
			ln_Enable("a");
		} else {
			ln_Enable("s");
		}
		**/
</script>


<script language=JavaScript for=gcra_ct event=OnSelChange()>
/**
		if(gcra_ct.CodeValue=="t"){
			txt_work_no.disabled=false;
			txt_work_no.focus();
		} else if(gcra_ct.CodeValue=="c"){
			txt_work_no.disabled=true;
		}
**/
</script>


<script language=JavaScript for=gcem_tel_dura event=onKeyUp(kcode,scode)>
	/**
		var usetime = gcem_tel_dura.text;
		var money   = gcds_cm002.NameValue(gcds_cm002.rowposition,"ITEM1");
		txt_up_sid.value=usetime * money;
	**/
</script>

<script language=JavaScript for=gcem_telNum event=onKeyDown(kcode,scode)>
/**
    if (kcode != 13) return;
		var temp= gcem_telNum.text;
    var chk="";

		temp = temp.replace("-","");
		temp = temp.replace("-","");

		//alert("temp::"+temp);
    //alert(temp.length);
		for (i=0;i<temp.length;i++){
			if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				chk="N";
			}else{
				chk="C";
				break;
			}
		}

		if(chk=="N"){
			//alert("����");
			var str1 = temp;

			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str1=" + str1;//����(��ȭ��ȣ)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();			
		}else{
      //alert("����");
			var str2 = temp;
			var sdata = "/services/servlet/sales.bm.bm052i_s02"
								+ "?v_str2=" + str2;//����(����ó)
			gcds_data_2.DataID = sdata; 
			gcds_data_2.Reset();
		}
	**/
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
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
 			<img src="/services/Sales/images/refer.gif"		style="cursor:hand" onclick="ln_Query()">
			<img src="/services/Sales/images/excel_apply.gif"	style="cursor:hand" onClick="ln_ExcelApply()">	<!--����//-->
			<img src="/services/Sales/images/db_apply.gif"	style="cursor:hand" onClick="ln_DBApply()">	<!--��ȭ��Ͼ��ε�//-->
			<img src="/services/Sales/images/sync.gif"	style="cursor:hand" onClick="ln_SyncA()">	<!--����ȭ//-->
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>	
					<td class="tab_a0100">�ش���</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:47px;">
						<comment id="__NSID__"><OBJECT id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:42px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<img src="/services/Sales/images/help.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_yymm', 'Text');" style="position:relative;width:20px;left:5px;cursor:hand;top:2px;">
					</td>				
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp01 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:203px;" viewastext>
							<param name="DataID"				value="gcds_data_1">
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
							  	<F> Name='No.'			      ID={CURROW}     HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
									<C> Name='��¥'		        ID=UP_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	  align=center mask='XXXX/XX/XX'</C> 
									<C> Name='����ȣ'		    ID=UP_NUM			  HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
									<C> Name='��ȭ��ȣ'		    ID=TEL_NUM			HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
									<C> Name='��ȭ����ð�'		ID=END_TIME			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	  align=center mask='XX:XX:XX' </C> 
									<C> Name='��ȭ�ð�(��)'		ID=TEL_DURA		  HeadAlign=Center HeadBgColor=#EEEEEE Width=75	  align=center</C> 
									<C> Name='�ݾ�'		        ID=TEL_FEE			HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
			  <tr><td align=center width="400"><b>��ȭ�̷�</b></td><td align=center width="60"></td><td align=center  width="400"><b>��ȭ ���ε�</b></td></tr>
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp02 class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:400px;height:203px;" viewastext>
							<param name="DataID"				value="gcds_data_2">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="20">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="IndWidth"      value="0">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="IndWidth"      value="0">
							<param name="Format"				value="  
								<F> Name='No.'				    ID={currow}     HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
									<C> Name='��ȭ����'		  ID=TEL_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center  mask='XXXX/XX/XX'</C> 
									<C> Name='��ȭ��ȣ'		  ID=TEL_NUM			HeadAlign=Center HeadBgColor=#EEEEEE Width=95	align=center</C> 
									<G> Name='��ȭ'                         HeadAlign=Center HeadBgColor=#EEEEEE
									<C> Name='���۽ð�'	    ID=TEL_STIME		HeadAlign=Center HeadBgColor=#EEEEEE Width=54	align=center mask='XX:XX:XX' </C> 
									<C> Name='����ð�'	    ID=TEL_ETIME		HeadAlign=Center HeadBgColor=#EEEEEE Width=54	align=center mask='XX:XX:XX'</C> 
									<C> Name='�ð�(��)'	    ID=TEL_DURA			HeadAlign=Center HeadBgColor=#EEEEEE Width=40	align=center </C> 
									<C> Name='�ݾ�'		      ID=TEL_FEE			HeadAlign=Center HeadBgColor=#EEEEEE Width=40	align=center</C> 
									</G>
								">

            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div2 style="width:402px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt2 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
					<td style="width:400px;" align=center><img src="/services/Sales/images/sync.gif"	align=center	style="cursor:hand" onclick="ln_SyncB()"></td>
					<td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp03 class="tab_b1111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:400px;height:203px;" viewastext>
							<param name="DataID"				value="gcds_data_3">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="20">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="IndWidth"      value="0">
							<param name="Format"				value="  
								<F> Name='No.'				    ID=PARM0   	 HeadAlign=Center HeadBgColor=#EEEEEE Width=33	align=center</F>
									<C> Name='��¥'		      ID=PARM1		 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center mask='XXXX/XX/XX'</C> 
									<C> Name='���\\��ȣ'		ID=PARM2		 HeadAlign=Center HeadBgColor=#EEEEEE Width=55	align=center</C> 
									<C> Name='��ȭ��ȣ'		  ID=PARM3		 HeadAlign=Center HeadBgColor=#EEEEEE Width=95	align=center</C> 
									<G> Name='��ȭ'                      HeadAlign=Center HeadBgColor=#EEEEEE
									<C> Name='����ð�'	    ID=PARM4		 HeadAlign=Center HeadBgColor=#EEEEEE Width=54	align=center mask='XX:XX:XX'</C> 
									<C> Name='��'	          ID=PARM5		 HeadAlign=Center HeadBgColor=#EEEEEE Width=40	align=center  </</C> 
									<C> Name='�ݾ�'		      ID=PARM6		 HeadAlign=Center HeadBgColor=#EEEEEE Width=40	align=right</C> 
									</G>
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div3 style="width:402px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt3 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
