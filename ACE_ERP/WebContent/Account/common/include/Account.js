
//ȸ�� ��ǥ���� �������� ����ϴ� �Լ��� �Է��ϴ� ����.
//2008.07.23 ���� �����.

//2011.01.01 ����ڴ������� �������� ����ڵ�Ϲ�ȣ ������.
//var gs_regno_s = "1018510695";   //���� ����� ��Ϲ�ȣ
var gs_regno_s = "2218113834";   //���� ����� ��Ϲ�ȣ
var gs_regno_g = "2218113834";   //�� ����� ��Ϲ�ȣ 

//var gs_comname_s = "����ƻ��ֽ�ȸ��(��������)";   //����ƻ��ֽ�ȸ��(���� ����)
var gs_comname_s = "����ƻ��ֽ�ȸ��(������)";   //����ƻ��ֽ�ȸ��(���� ����)
var gs_comname_g = "����ƻ��ֽ�ȸ��(������)";   //����ƻ��ֽ�ȸ��(���� ��)

//var gs_url="http://203.242.32.193:10000";
//2013.12.23.JYS ���� 
//var gs_url="http://203.242.32.193:80"; ���� ���ݰ�꼭 �߰輭�� 
var gs_url="http://203.242.32.126:80";   //����ȭ ���ݰ�꼭 �߰輭��  

var gc_date=""; 

/*****************************************************************************
	Description : �ε��� �ش� ���� �ϼ� ��������
	parameter   : gb - s : ��������
	                   c : ��������
******************************************************************************/
function ln_Load_Date(gb){

	if(gb=="s"){
		gc_date = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";     
	}else if(gb=="c"){
  	    gc_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	}
	return gc_date;
}
/*****************************************************************************
	Description : �ݾ� lock����
	parameter   : row  - rowposition ��.
******************************************************************************/
function ln_Dtl_Amt_Lock(row){

	//���� ���� ������ �� �ݾ� LOCK=========================================================
	//2008.07.23. ������
	gcem_detot02.Enable = true;
	gcem_crtot02.Enable = true;
	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
		if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
			gcem_detot02.Enable = false;
			gcem_crtot02.Enable = false;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
			gcem_detot02.Enable = false;
			gcem_crtot02.Enable = false;	
		}
	}
	//======================================================================================
	
	if(gs_team_user=="false"){ //ȸ������ �ƴҰ��
		//���޺ΰ���ġ��/�����ΰ���ġ�� �� ���
		if(gcds_dtl.namevalue(row,"ATCODE")=="1112300"||gcds_dtl.namevalue(row,"ATCODE")=="2101100"){
			gcem_detot02.ReadOnly = "true"; 
			gcem_crtot02.ReadOnly = "true"; 
		}else{
			gcem_detot02.ReadOnly = "false"; 
			gcem_crtot02.ReadOnly = "false"; 
		}
	}
}

/*****************************************************************************
	Description : �������� lock����
	parameter   : row  - rowposition ��.
******************************************************************************/
function ln_Atcode_Lock(row){
	//���� ���� ������ �� �ݾ� LOCK=========================================================
	//2008.07.23. ������
	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
		if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;	
		}else{
			gcem_atcode02.Enable = true;
			gcem_atkornam02.Enable = true;
		}
	}else{
		gcem_atcode02.Enable = true;
		gcem_atkornam02.Enable = true;
	}
	//======================================================================================
	
	if(gs_team_user=="false"){ //ȸ������ �ƴҰ��
		//���޺ΰ���ġ��/�����ΰ���ġ�� �� ���
		if(gcds_dtl.namevalue(row,"ATCODE")=="1112300"||gcds_dtl.namevalue(row,"ATCODE")=="2101100"){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;	
		}
	}
}

/*******************************************************************************************
	Description : �����ޱ�(���θ����ī��)�� �ŷ�ó ���ý� ����, ī���ȣ, ī������, ���¹�ȣ 
	              �ڵ����� �� LOCK
	parameter   : row  - rowposition ��.
*********************************************************************************************/
function ln_Ref_Card_Lock(gb,row){
	if(gb=="T"){ //true
		gcem_fsrvalnm03.Enable = true;
		gcem_fsrvalnm04.Enable = true;
		gcem_fsrvalnm05.Enable = true;
		gcem_fsrvalnm06.Enable = true;
	}else{ //false 
        gcem_fsrvalnm03.Enable = false;
		gcem_fsrvalnm04.Enable = false;
		gcem_fsrvalnm05.Enable = false;
		gcem_fsrvalnm06.Enable = false;
	}
}

/*******************************************************************************************
	Description : �����ޱ�(���θ����ī��)�� �ŷ�ó ���ý� ����, ī���ȣ, ī������, ���¹�ȣ 
	              �ڵ����� �� LOCK
	parameter   : row  - rowposition ��.
*********************************************************************************************/
function ln_Card_Data_Setting(){
	
	//alert("ln_Card_Data_Setting");

	gcds_card.DataID = g_servlet+"/Account.comm_card_s2?v_str1="+txt_vendcd02.value
							+"&v_str2="+gcem_actdat02.text  
							
    //prompt("",gcds_card.dataid);							
	gcds_card.Reset();		 

	if(gcds_card.countrow>0){
		strPo="";
		strPo = ln_Ref_position_find("2168"); //����
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CAACCBANK");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"BANKNM");

		strPo="";
		strPo =  ln_Ref_position_find("2167"); //ī���ȣ
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CANBR");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"CARDNO");

		strPo="";
		strPo = ln_Ref_position_find("1134"); //ī������
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CACARDSPEC");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"CARDKD");

		strPo="";
		strPo = ln_Ref_position_find("2166"); //���¹�ȣ
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CABANKNO");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"ACCNO");
		return true;
	}else{

	//  �ŷ�ó �ʱ�ȭ
		//alert("["+gcem_vendnm02.text+"]�� ���� ���θ����ī�� ������ �������� �ʽ��ϴ�.");           
		txt_vendcd02.value="";
		gcem_vendnm02.text = "";
		//LOCK ���� 
		ln_Ref_Card_Lock("F",gcds_dtl.rowposition);
		strPo="";
		strPo = ln_Ref_position_find("2168"); //����
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text ="";

		strPo="";
		strPo =  ln_Ref_position_find("2167"); //ī���ȣ
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text ="";

		strPo="";
		strPo = ln_Ref_position_find("1134"); //ī������
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text = "";

		strPo="";
		strPo = ln_Ref_position_find("2166"); //���¹�ȣ
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text = "";
		return false;
	}
}