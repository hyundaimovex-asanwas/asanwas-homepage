<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ������� - ���������
+ ���α׷� ID	:   H060013.html
+ �� �� �� ��	:   
+ �� �� �� ��	: 
+ �� �� �� ��	:   h060013_s1, h060013_s2,
+                hcdept_s1, hclcode_s1, h060013_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>���������</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
var strgcem_yyymm
var j=0;
var cntchk = "N"; 
var gs_level;
var gs_treecd;
get_cookdata();
lfn_init();
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_yymm.text = gcurdate.substring(0,7); 
  strgcem_yyymm= gcem_yymm.text;

	//�����ڵ�
	ln_Luxecombo_load();  
  txt_evaseq.value="";
}

/******************************************************************************
	Description : �ǰ���� ��ȸ
******************************************************************************/
function ln_Query(){
	
	if (fn_trim(gcem_yymm.text)==""){
		alert("�������� �Է��Ͻʽÿ�.");
	}
    		
	gcds_data.DataID = "/servlet/Person.h060013_s1?v_str1="+fn_trim(gcem_yymm.text)
	                                                     +"&v_str2="+fn_trim(gclx_deptcd.bindcolval)
	                                                     +"&v_str3="+fn_trim(gclx_paygrd.bindcolval)
	                                                     +"&v_str4="+fn_trim(txt_name.value)
																											 +"&v_str5="+gs_level
																										   +"&v_str6="+gs_treecd;
	//prompt("gcds_data", gcds_data.DataID);
	gcds_data.Reset();  

	ln_Reset("q");

}


/******************************************************************************
	Description : ����� ��ȸ
******************************************************************************/

function ln_Query2(){

	if (fn_trim(gcem_yymm.text)==""){
		alert("�������� �Է��Ͻʽÿ�.");
	}
    		
	gcds_data2.DataID = "/servlet/Person.h060013_s2?v_str1="+fn_trim(gcem_yymm.text)
																												+"&v_str2="+fn_trim(gclx_deptcd.bindcolval)
																												+"&v_str3="+fn_trim(gclx_paygrd.bindcolval)
																												+"&v_str4="+fn_trim(txt_name.value)
																												+"&v_str5="+fn_trim(txt_empnoh.value)
																												+"&v_str6="+fn_trim(txt_evaseq.value)
																												+"&v_str7="+gs_level
																										    +"&v_str8="+gs_treecd;
	//prompt("gcds_data2", gcds_data2.DataID);
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
function ln_Save(){
	
	if (gcds_data2.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if(ln_Chk()){
			if(ln_Chk2()){
			  if (confirm("�����Ͻðڽ��ϱ�?")) {
					//prompt("gcds_data2",  gcds_data2.text );
					gctr_data.action = "/servlet/Person.h060013_t1";
				//	prompt("gcds_data2",  gcds_data2.text );
				//
					gctr_data.post();
					ln_Query2();
				}
				
			} //if ln_Chk2
		}//if ln_Chk
	}
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
	if (gcgd_empno.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	//else gcgd_grid_ec01az.RunExcel('�޿�����');
	else gcgd_empno.GridToExcel("���������(����)","",2);
}

/******************************************************************************
	Description : ����� ���� Grid �ʱ�ȭ
	parameter - q : query��   r -reset �ʱ�ȭ
******************************************************************************/
function ln_Reset(p){

	if(p=="r"){
		if (gcds_data2.countrow>=1){
			gcds_data2.ClearData();	 
      txt_empnoh.value="";
			txt_empnmkh.value="";
			txt_evaseq.value="";
		}else{
			txt_empnoh.value ="";
			txt_empnmkh.value="";
			alert("�ʱ�ȭ �� �����Ͱ� �������� �ʽ��ϴ�.");
		}
	}else if(p=="q"){
		if (gcds_data2.countrow>=1) gcds_data2.ClearData();
	}
}


/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//�Ҽ�
	gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?";  
	//prompt("gcds_deptcd", gcds_deptcd.DataID);
	gcds_deptcd.Reset();
    
	//����
	gcds_paygrd.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";  
	//prompt("gcds_paygrd", gcds_paygrd.DataID);
	gcds_paygrd.Reset();
}


/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_FindEmp(e, row){
  var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

	if (gs_treecd.length!=0 && gs_level!=0){
		gs_treecd = fn_treecd(gs_level, gs_treecd);
		arrParam[0]=gs_level;  
		arrParam[1]=gs_treecd;
	}else {
		arrParam[0]='';  
		arrParam[1]='';
	}
  
	strURL = "./H030003_popup_3.html";
	strPos = "dialogWidth:377px;dialogHeight:390px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];
   
		if (e=="txt_empnmkh") {
		  txt_empnmkh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];
			txt_paygrd.value = arrResult[2];
			txt_paygnm.value = arrResult[3];
			txt_deptcd.value = arrResult[4];
			txt_deptnm.value = arrResult[5];
			txt_strtdt.value = arrResult[6];

		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];
			gcds_data2.namevalue(row,"PAYGRD") = arrResult[2];
			gcds_data2.namevalue(row,"PAYGRDNM")=fn_trim(arrResult[3]); 
			gcds_data2.namevalue(row,"DEPTCD") = arrResult[4];
			gcds_data2.namevalue(row,"DEPTNM")= fn_trim(arrResult[5]); 
			gcds_data2.namevalue(row,"STRTDT") = arrResult[6];
			
		}
	} else {
		//eval(e).value = "";
		if (e=="txt_empnmkh") {
		  txt_empnmkh.value="";
			txt_empnoh.value ="";
			txt_paygrd.value = "";
			txt_paygnm.value = "";
			txt_deptcd.value = "";
			txt_deptnm.value = "";
			txt_strtdt.value="";
		}
	}
}

/******************************************************************************
	Description : ����� ���� 
******************************************************************************/
function ln_Appoint(){

	if (gcds_data.countrow > 0 ) { 
		if  (ln_Appoint_Chk()){
			for ( i=1;i<=gcds_data.countrow;i++){
				if (gcds_data.namevalue(i,"CHK") =="T"){
				    
					ln_Header_create();
					gcds_data2.addrow();
					j = gcds_data2.countrow;
					gcds_data2.namevalue(j,"CHKOUT") = "F";
					gcds_data2.namevalue(j,"EVAYM") =  fn_trim(gcem_yymm.text);
					gcds_data2.namevalue(j,"EMPNOH") = txt_empnoh.value ;                        //�����
					gcds_data2.namevalue(j,"EMPNMKH") = txt_empnmkh.value ;                   //����ڸ�
					gcds_data2.namevalue(j,"EVASEQ"  ) = txt_evaseq.value ;               //����
					gcds_data2.namevalue(j,"EMPNO") = gcds_data.namevalue(i,"EMPNO") ;   //�ǰ����
					gcds_data2.namevalue(j,"EMPNMK") = gcds_data.namevalue(i,"EMPNMK") ; //�ǰ���ڸ�

                    //���������
					gcds_data2.namevalue(j,"DEPTCD") = txt_deptcd.value; //�Ҽ��ڵ�
					gcds_data2.namevalue(j,"DEPTNM") = fn_trim(txt_deptnm.value); //�ҼӸ�
					gcds_data2.namevalue(j,"PAYGRD") = txt_paygrd.value; //�����ڵ�
					gcds_data2.namevalue(j,"PAYGRDNM") = fn_trim(txt_paygnm.value); //������
					gcds_data2.namevalue(j,"STRTDT") = txt_strtdt.value; //�Ի���
					ln_Evaseq(i, fn_trim(txt_evaseq.value), txt_empnmkh.value);				
				}
			} //for
		}
	}else{
		alert("�����Ͱ� �������� �ʽ��ϴ�");
	}
}

/******************************************************************************
	Description : ����� ���� ����Ÿ�� ��� ���� 
******************************************************************************/
function ln_Header_create(){

	if (gcds_data2.countrow<1){
		var Header1= "CHKOUT:STRING,EVAYM:STRING, EMPNOH:STRING,EMPNMKH:STRING,EMPNO:STRING,EMPNMK:STRING,EVASEQ:DECIMAL,DEPTCD:STRING,DEPTNM:STRING,STRTDT:STRING, PAYGRD:STRING,PAYGRDNM:STRING, ODLEMPNOH:STRING, OLDEVASEQ:DECIMAL";
		gcds_data2.SetDataHeader(Header1);
	}
}

/******************************************************************************
	Description : �ǰ���� ���� �ڵ� ����
	parameter : i - rowposition, seq - ����, name - �ǰ���ڸ�
******************************************************************************/
function ln_Evaseq(i,seq, name){

	if (seq == "1" ) {
		gcds_data.namevalue(i,"EMPNMK1") = name;
	}else if (seq == "2" ){
		gcds_data.namevalue(i,"EMPNMK2") = name; 	
	}else if (seq == "3" ){
		gcds_data.namevalue(i,"EMPNMK3") = name; 	
  }else if (seq == "4" ){
		gcds_data.namevalue(i,"EMPNMK4") = name; 	
	}else if (seq == "5" ){
		gcds_data.namevalue(i,"EMPNMK5") = name; 	
	}else if (seq == "6" ){
		gcds_data.namevalue(i,"EMPNMK6") = name; 	
	}else if (seq == "7" ){
		gcds_data.namevalue(i,"EMPNMK7") = name; 	
  }else if (seq == "8" ){
		gcds_data.namevalue(i,"EMPNMK8") = name; 	
	}else if (seq == "9" ){
		gcds_data.namevalue(i,"EMPNMK9") = name; 
  }else if (seq == "10" ){
		gcds_data.namevalue(i,"EMPNMK10") = name; 
  }else if (seq == "11" ){
		gcds_data.namevalue(i,"EMPNMK11") = name; 	
	}else if (seq == "12" ){
		gcds_data.namevalue(i,"EMPNMK12") = name; 	
  }else if (seq == "13" ){
		gcds_data.namevalue(i,"EMPNMK13") = name; 	
	}else if (seq == "14" ){
		gcds_data.namevalue(i,"EMPNMK14") = name; 	
	}else if (seq == "15" ){
		gcds_data.namevalue(i,"EMPNMK15") = name; 	
	}else if (seq == "16" ){
		gcds_data.namevalue(i,"EMPNMK16") = name; 	
  }else if (seq == "17" ){
		gcds_data.namevalue(i,"EMPNMK17") = name; 	
	}else if (seq == "18" ){
		gcds_data.namevalue(i,"EMPNMK18") = name; 
  }else if (seq == "19" ){
		gcds_data.namevalue(i,"EMPNMK19") = name; 
  }else if (seq == "20" ){
		gcds_data.namevalue(i,"EMPNMK20") = name; 
  }else if (seq == "21" ){
		gcds_data.namevalue(i,"EMPNMK21") = name; 	
	}else if (seq == "22" ){
		gcds_data.namevalue(i,"EMPNMK22") = name; 	
  }else if (seq == "23" ){
		gcds_data.namevalue(i,"EMPNMK23") = name; 	
	}else if (seq == "24" ){
		gcds_data.namevalue(i,"EMPNMK24") = name; 	
	}else if (seq == "25" ){
		gcds_data.namevalue(i,"EMPNMK25") = name; 	
	}else if (seq == "26" ){
		gcds_data.namevalue(i,"EMPNMK26") = name; 	
  }else if (seq == "27" ){
		gcds_data.namevalue(i,"EMPNMK27") = name; 	
	}else if (seq == "28" ){
		gcds_data.namevalue(i,"EMPNMK28") = name; 
  }else if (seq == "29" ){
		gcds_data.namevalue(i,"EMPNMK29") = name; 
  }else if (seq == "30" ){
		gcds_data.namevalue(i,"EMPNMK30") = name; 
  }else if (seq == "31" ){
		gcds_data.namevalue(i,"EMPNMK31") = name; 	
	}else if (seq == "32" ){
		gcds_data.namevalue(i,"EMPNMK32") = name; 	
  }else if (seq == "33" ){
		gcds_data.namevalue(i,"EMPNMK33") = name; 	
	}else if (seq == "34" ){
		gcds_data.namevalue(i,"EMPNMK34") = name; 	
	}else if (seq == "35" ){
		gcds_data.namevalue(i,"EMPNMK35") = name; 	
	}else if (seq == "36" ){
		gcds_data.namevalue(i,"EMPNMK36") = name; 	
  }else if (seq == "37" ){
		gcds_data.namevalue(i,"EMPNMK37") = name; 	
	}else if (seq == "38" ){
		gcds_data.namevalue(i,"EMPNMK38") = name; 
  }else if (seq == "39" ){
		gcds_data.namevalue(i,"EMPNMK39") = name; 
  }else if (seq == "40" ){
		gcds_data.namevalue(i,"EMPNMK40") = name; 
  }else if (seq == "41" ){
		gcds_data.namevalue(i,"EMPNMK41") = name; 	
	}else if (seq == "42" ){
		gcds_data.namevalue(i,"EMPNMK42") = name; 	
  }else if (seq == "43" ){
		gcds_data.namevalue(i,"EMPNMK43") = name; 	
	}else if (seq == "44" ){
		gcds_data.namevalue(i,"EMPNMK44") = name; 	
	}else if (seq == "45" ){
		gcds_data.namevalue(i,"EMPNMK45") = name; 	
	}else if (seq == "46" ){
		gcds_data.namevalue(i,"EMPNMK46") = name; 	
  }else if (seq == "47" ){
		gcds_data.namevalue(i,"EMPNMK47") = name; 	
	}else if (seq == "48" ){
		gcds_data.namevalue(i,"EMPNMK48") = name; 
  }else if (seq == "49" ){
		gcds_data.namevalue(i,"EMPNMK49") = name; 
  }else if (seq == "50" ){
		gcds_data.namevalue(i,"EMPNMK50") = name; 
  }else if (seq == "51" ){
		gcds_data.namevalue(i,"EMPNMK51") = name; 	
	}else if (seq == "52" ){
		gcds_data.namevalue(i,"EMPNMK52") = name; 	
  }else if (seq == "53" ){
		gcds_data.namevalue(i,"EMPNMK53") = name; 	
	}else if (seq == "54" ){
		gcds_data.namevalue(i,"EMPNMK54") = name; 	
	}else if (seq == "55" ){
		gcds_data.namevalue(i,"EMPNMK55") = name; 	
	}else if (seq == "56" ){
		gcds_data.namevalue(i,"EMPNMK56") = name; 	
  }else if (seq == "57" ){
		gcds_data.namevalue(i,"EMPNMK57") = name; 	
	}else if (seq == "58" ){
		gcds_data.namevalue(i,"EMPNMK58") = name; 
  }else if (seq == "59" ){
		gcds_data.namevalue(i,"EMPNMK59") = name; 
  }else if (seq == "60" ){
		gcds_data.namevalue(i,"EMPNMK60") = name; 
  }
}

/******************************************************************************
	Description : ����� ������ üũ
--------------------------------------------------------------------------------------------------------------
	//�ǰ���ڰ� ���� ��� 
	//����ڰ� ���°��
	//������ ���� ���
	//�ǰ���ڿ� ����ڰ� ������ ���(����� ���� ���)
	//�ǰ���ڿ� ����ڰ� �������� ������,  �ǰ������ ������ �ߺ��Ǵ°��
	//���� �ǰ���ڿ� ���ؼ�  ������ �����Ѱ��

******************************************************************************/
function ln_Appoint_Chk(){
	var seq1="9",seq2="9",seq3="9",seq4="9",seq5="9",seq6="9",seq7="9",seq8="9",seq9="9",seq10="9" ; 
  var seq11="9", seq12="9",seq13="9",seq14="9",seq15="9", seq16="9",seq17="9",seq18="9",seq19="9", seq20="9" ;
  var seq21="9", seq22="9",seq23="9",seq24="9",seq25="9", seq26="9",seq27="9",seq28="9",seq29="9", seq30="9";
  var seq31="9", seq32="9",seq33="9",seq34="9",seq35="9", seq36="9",seq37="9",seq38="9",seq39="9", seq40="9";
  var seq41="9", seq42="9",seq43="9",seq44="9",seq45="9", seq46="9",seq47="9",seq48="9",seq49="9", seq50="9";
  var seq51="9", seq52="9",seq53="9",seq54="9",seq55="9", seq56="9",seq57="9",seq58="9",seq59="9", seq60="9";

	var seq_val="0";
	seq_val =fn_trim(txt_evaseq.value);

	for ( i=1;i<=gcds_data.countrow;i++){
		if (gcds_data.namevalue(i,"CHK") =="T") cntchk = "Y";
	}

	 i= 0 ;
	if (cntchk =="N"){
		alert("���õ� �ǰ���ڰ� �����ϴ�.");
		return;
	}
	cntchk = "N";
	if (fn_trim(txt_empnoh.value)=="" &&  fn_trim(txt_empnmkh.value)=="") {
		alert( "����ڰ� �������� �ʽ��ϴ�.")
		return false;
	}
	
	if (fn_trim(txt_evaseq.value)=="") {
		alert( "������ �������� �ʽ��ϴ�.")
		return false;
	}

	for ( i=1;i<=gcds_data.countrow;i++){
	
		if ( gcds_data.namevalue(i,"CHK") =="T"){

			if(gcds_data.namevalue(i,"EMPNO") == fn_trim(txt_empnoh.value)){
				alert("�ǰ���ڿ� ����ڰ� �����մϴ�");
				return false ;
			}else{

				
				if  (gcds_data2.countrow>0 ){
				
					for ( j=1;j<=gcds_data2.countrow;j++){
						if((gcds_data2.namevalue(j,"EVASEQ")==fn_trim(txt_evaseq.value)) &&   (gcds_data2.namevalue(j,"EMPNO")==gcds_data.namevalue(i,"EMPNO"))) {
							alert("���� �ǰ������  ����� ������ �����մϴ�.");
							return false;
							break;
						 }//if

						if ((gcds_data.namevalue(i,"EMPNMK1")!="")) seq1="1";
						if ((gcds_data.namevalue(i,"EMPNMK2")!="")) seq2="2";
						if ((gcds_data.namevalue(i,"EMPNMK3")!="")) seq3="3";
						if ((gcds_data.namevalue(i,"EMPNMK4")!="")) seq4="4";
						if ((gcds_data.namevalue(i,"EMPNMK5")!="")) seq5="5";
						if ((gcds_data.namevalue(i,"EMPNMK6")!="")) seq6="6";
						if ((gcds_data.namevalue(i,"EMPNMK7")!="")) seq7="7";
						if ((gcds_data.namevalue(i,"EMPNMK8")!="")) seq8="8";
						if ((gcds_data.namevalue(i,"EMPNMK9")!="")) seq9="9";
						if ((gcds_data.namevalue(i,"EMPNMK10")!="")) seq10="10";
						if ((gcds_data.namevalue(i,"EMPNMK11")!="")) seq11="11";
						if ((gcds_data.namevalue(i,"EMPNMK12")!="")) seq12="12";
            if ((gcds_data.namevalue(i,"EMPNMK13")!="")) seq13="13";
						if ((gcds_data.namevalue(i,"EMPNMK14")!="")) seq14="14";
						if ((gcds_data.namevalue(i,"EMPNMK15")!="")) seq15="15";
						if ((gcds_data.namevalue(i,"EMPNMK16")!="")) seq16="16";
						if ((gcds_data.namevalue(i,"EMPNMK17")!="")) seq17="17";
						if ((gcds_data.namevalue(i,"EMPNMK18")!="")) seq18="18";
						if ((gcds_data.namevalue(i,"EMPNMK19")!="")) seq19="19";
						if ((gcds_data.namevalue(i,"EMPNMK20")!="")) seq20="20";
						if ((gcds_data.namevalue(i,"EMPNMK21")!="")) seq21="21";
						if ((gcds_data.namevalue(i,"EMPNMK22")!="")) seq22="22";
            if ((gcds_data.namevalue(i,"EMPNMK23")!="")) seq23="23";
						if ((gcds_data.namevalue(i,"EMPNMK24")!="")) seq24="24";
						if ((gcds_data.namevalue(i,"EMPNMK25")!="")) seq25="25";
						if ((gcds_data.namevalue(i,"EMPNMK26")!="")) seq26="26";
						if ((gcds_data.namevalue(i,"EMPNMK27")!="")) seq27="27";
						if ((gcds_data.namevalue(i,"EMPNMK28")!="")) seq28="28";
						if ((gcds_data.namevalue(i,"EMPNMK29")!="")) seq28="29";
						if ((gcds_data.namevalue(i,"EMPNMK30")!="")) seq30="30";
						if ((gcds_data.namevalue(i,"EMPNMK31")!="")) seq31="31";
						if ((gcds_data.namevalue(i,"EMPNMK32")!="")) seq32="32";
            if ((gcds_data.namevalue(i,"EMPNMK33")!="")) seq33="33";
						if ((gcds_data.namevalue(i,"EMPNMK34")!="")) seq44="34";
						if ((gcds_data.namevalue(i,"EMPNMK35")!="")) seq35="35";
						if ((gcds_data.namevalue(i,"EMPNMK36")!="")) seq36="36";
						if ((gcds_data.namevalue(i,"EMPNMK37")!="")) seq37="37";
						if ((gcds_data.namevalue(i,"EMPNMK38")!="")) seq38="38";
						if ((gcds_data.namevalue(i,"EMPNMK39")!="")) seq39="39";
						if ((gcds_data.namevalue(i,"EMPNMK40")!="")) seq40="40";
						if ((gcds_data.namevalue(i,"EMPNMK41")!="")) seq41="41";
						if ((gcds_data.namevalue(i,"EMPNMK42")!="")) seq42="42";
            if ((gcds_data.namevalue(i,"EMPNMK43")!="")) seq43="43";
						if ((gcds_data.namevalue(i,"EMPNMK44")!="")) seq44="44";
						if ((gcds_data.namevalue(i,"EMPNMK45")!="")) seq45="45";
						if ((gcds_data.namevalue(i,"EMPNMK46")!="")) seq46="46";
						if ((gcds_data.namevalue(i,"EMPNMK47")!="")) seq47="47";
						if ((gcds_data.namevalue(i,"EMPNMK48")!="")) seq48="48";
						if ((gcds_data.namevalue(i,"EMPNMK49")!="")) seq49="49";
						if ((gcds_data.namevalue(i,"EMPNMK50")!="")) seq50="50";
						if ((gcds_data.namevalue(i,"EMPNMK51")!="")) seq51="51";
						if ((gcds_data.namevalue(i,"EMPNMK52")!="")) seq52="52";
            if ((gcds_data.namevalue(i,"EMPNMK53")!="")) seq53="53";
						if ((gcds_data.namevalue(i,"EMPNMK54")!="")) seq54="54";
						if ((gcds_data.namevalue(i,"EMPNMK55")!="")) seq55="55";
						if ((gcds_data.namevalue(i,"EMPNMK56")!="")) seq56="56";
						if ((gcds_data.namevalue(i,"EMPNMK57")!="")) seq57="57";
						if ((gcds_data.namevalue(i,"EMPNMK58")!="")) seq58="58";
						if ((gcds_data.namevalue(i,"EMPNMK59")!="")) seq59="59";
						if ((gcds_data.namevalue(i,"EMPNMK60")!="")) seq60="60";

				  	if((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)){
					 		alert("���� ������ �����մϴ�.");
					 		return false ;
					 	}
					}//for
				}else if(gcds_data2.countrow<=0){
					
	
						if ((gcds_data.namevalue(i,"EMPNMK1")!="")) seq1="1";
						if ((gcds_data.namevalue(i,"EMPNMK2")!="")) seq2="2";
						if ((gcds_data.namevalue(i,"EMPNMK3")!="")) seq3="3";
						if ((gcds_data.namevalue(i,"EMPNMK4")!="")) seq4="4";
						if ((gcds_data.namevalue(i,"EMPNMK5")!="")) seq5="5";
						if ((gcds_data.namevalue(i,"EMPNMK6")!="")) seq6="6";
						if ((gcds_data.namevalue(i,"EMPNMK7")!="")) seq7="7";
						if ((gcds_data.namevalue(i,"EMPNMK8")!="")) seq8="8";
						if ((gcds_data.namevalue(i,"EMPNMK9")!="")) seq9="9";
						if ((gcds_data.namevalue(i,"EMPNMK10")!="")) seq10="10";
						if ((gcds_data.namevalue(i,"EMPNMK11")!="")) seq11="11";
						if ((gcds_data.namevalue(i,"EMPNMK12")!="")) seq12="12";
            if ((gcds_data.namevalue(i,"EMPNMK13")!="")) seq13="13";
						if ((gcds_data.namevalue(i,"EMPNMK14")!="")) seq14="14";
						if ((gcds_data.namevalue(i,"EMPNMK15")!="")) seq15="15";
						if ((gcds_data.namevalue(i,"EMPNMK16")!="")) seq16="16";
						if ((gcds_data.namevalue(i,"EMPNMK17")!="")) seq17="17";
						if ((gcds_data.namevalue(i,"EMPNMK18")!="")) seq18="18";
						if ((gcds_data.namevalue(i,"EMPNMK19")!="")) seq19="19";
						if ((gcds_data.namevalue(i,"EMPNMK20")!="")) seq20="20";
						if ((gcds_data.namevalue(i,"EMPNMK21")!="")) seq21="21";
						if ((gcds_data.namevalue(i,"EMPNMK22")!="")) seq22="22";
            if ((gcds_data.namevalue(i,"EMPNMK23")!="")) seq23="23";
						if ((gcds_data.namevalue(i,"EMPNMK24")!="")) seq24="24";
						if ((gcds_data.namevalue(i,"EMPNMK25")!="")) seq25="25";
						if ((gcds_data.namevalue(i,"EMPNMK26")!="")) seq26="26";
						if ((gcds_data.namevalue(i,"EMPNMK27")!="")) seq27="27";
						if ((gcds_data.namevalue(i,"EMPNMK28")!="")) seq28="28";
						if ((gcds_data.namevalue(i,"EMPNMK29")!="")) seq28="29";
						if ((gcds_data.namevalue(i,"EMPNMK30")!="")) seq30="30";
						if ((gcds_data.namevalue(i,"EMPNMK31")!="")) seq31="31";
						if ((gcds_data.namevalue(i,"EMPNMK32")!="")) seq32="32";
            if ((gcds_data.namevalue(i,"EMPNMK33")!="")) seq33="33";
						if ((gcds_data.namevalue(i,"EMPNMK34")!="")) seq44="34";
						if ((gcds_data.namevalue(i,"EMPNMK35")!="")) seq35="35";
						if ((gcds_data.namevalue(i,"EMPNMK36")!="")) seq36="36";
						if ((gcds_data.namevalue(i,"EMPNMK37")!="")) seq37="37";
						if ((gcds_data.namevalue(i,"EMPNMK38")!="")) seq38="38";
						if ((gcds_data.namevalue(i,"EMPNMK39")!="")) seq39="39";
						if ((gcds_data.namevalue(i,"EMPNMK40")!="")) seq40="40";
						if ((gcds_data.namevalue(i,"EMPNMK41")!="")) seq41="41";
						if ((gcds_data.namevalue(i,"EMPNMK42")!="")) seq42="42";
            if ((gcds_data.namevalue(i,"EMPNMK43")!="")) seq43="43";
						if ((gcds_data.namevalue(i,"EMPNMK44")!="")) seq44="44";
						if ((gcds_data.namevalue(i,"EMPNMK45")!="")) seq45="45";
						if ((gcds_data.namevalue(i,"EMPNMK46")!="")) seq46="46";
						if ((gcds_data.namevalue(i,"EMPNMK47")!="")) seq47="47";
						if ((gcds_data.namevalue(i,"EMPNMK48")!="")) seq48="48";
						if ((gcds_data.namevalue(i,"EMPNMK49")!="")) seq49="49";
						if ((gcds_data.namevalue(i,"EMPNMK50")!="")) seq50="50";
						if ((gcds_data.namevalue(i,"EMPNMK51")!="")) seq51="51";
						if ((gcds_data.namevalue(i,"EMPNMK52")!="")) seq52="52";
            if ((gcds_data.namevalue(i,"EMPNMK53")!="")) seq53="53";
						if ((gcds_data.namevalue(i,"EMPNMK54")!="")) seq54="54";
						if ((gcds_data.namevalue(i,"EMPNMK55")!="")) seq55="55";
						if ((gcds_data.namevalue(i,"EMPNMK56")!="")) seq56="56";
						if ((gcds_data.namevalue(i,"EMPNMK57")!="")) seq57="57";
						if ((gcds_data.namevalue(i,"EMPNMK58")!="")) seq58="58";
						if ((gcds_data.namevalue(i,"EMPNMK59")!="")) seq59="59";
						if ((gcds_data.namevalue(i,"EMPNMK60")!="")) seq60="60";

				 	if((seq1==seq_val)||(seq2==seq_val)||(seq3==seq_val)||(seq4==seq_val)||(seq5==seq_val)||(seq6==seq_val)||(seq7==seq_val)||(seq8==seq_val)||(seq9==seq_val)||(seq10==seq_val)||(seq11==seq_val)||(seq12==seq_val)||(seq13==seq_val)||(seq14==seq_val)){
					 		alert("���� ������ �����մϴ�.");
					 		return false ;
				 	
				 	}
				}//if
			}//if
		}//if
	}//for

	if (fn_trim(txt_empnoh.value)=="") {
		alert( "������ �������� �ʽ��ϴ�.")
		return false;
	}		
	return true;
}

/******************************************************************************
	Description : ����� ���� ����� üũ
    gcds_data2.namevalue(i, "CHKOUT")=="T"  : ����� ����
    UserStatus(i)=2  -- Delete
******************************************************************************/
function ln_Chk(){
	for(i=1; i<=gcds_data2.countrow;i++){
		if (gcds_data2.namevalue(i, "CHKOUT")=="T") {
			gcds_data2.UserStatus(i)=2;
		}
	}
	return true;
}

/******************************************************************************
	Description : ����� ������ �߻�
    
******************************************************************************/
function ln_Chk2(){

  window.status="üũ���Դϴ�.��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
	for(i=1; i<=gcds_data2.countrow;i++){
		for ( j=1;j<=gcds_data2.countrow;j++){
			if(i!=j){		
				if ((gcds_data2.namevalue(i,"EMPNO"))==(gcds_data2.namevalue(j,"EMPNO")) &&
				    (gcds_data2.namevalue(i,"EVASEQ"))==(gcds_data2.namevalue(j,"EVASEQ"))){
						
						window.status="üũ�� �Ϸ� �Ǿ����ϴ�.";
						//document.all.LowerFrame.style.visibility="hidden";
						alert("���� �ǰ������  ����� ������ �����մϴ�.");

						return false;
						break;
				}//if
			}//if
    } //for
	} //for 

	window.status="üũ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	return true;
}


/******************************************************************************
	Description : ��ü����
******************************************************************************/
function ln_Chkbox(){
	var chk="F";
	for ( i=1;i<=gcds_data.countrow;i++){
		if (gcds_data.namevalue(i,"CHK") =="T"){
			chk="T";
		}else{		
			chk="F";
			break;
		}
  }

	if (chk=="F"){
		for ( i=1;i<=gcds_data.countrow;i++){
			gcds_data.namevalue(i,"CHK") ="T";
		}
	}else{
		for ( i=1;i<=gcds_data.countrow;i++){
			gcds_data.namevalue(i,"CHK") ="F";
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_data2 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<param name="SortExpr" value="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_paygrd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<!-- <param name="SortExpr" value="+MINORNM"> -->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060013_t1(I:USER=gcds_data2)">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="1��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="2��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("3�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " 4��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="5����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="6��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
	window.status="7��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("8�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
			gcds_deptcd.insertrow(1);
			gcds_deptcd.namevalue(1,"DEPTCD") = "";
			gcds_deptcd.namevalue(1,"DEPTNM") = "��ü";
			gclx_deptcd.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
			gcds_paygrd.insertrow(1);
			gcds_paygrd.namevalue(1,"MINORCD") = "";
			gcds_paygrd.namevalue(1,"MINORNM") = "��ü";
			gclx_paygrd.index = 0;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-- ������������� ����-->
<script language=JavaScript for=gcgd_empno2 event=OnClick(row,colid)>
	if (gcds_data2.countrow<1) {
		return;
	}

	for(i=1;i<=gcds_data2.countrow;i++){
		if(gcds_data2.namevalue(i,"CHKOUT")=="T"){
			for(j=1;j<=gcds_data.countrow;j++){		

				if((gcds_data2.namevalue(i,"EVAYM")==gcds_data.namevalue(j,"EVAYM")) && 	(gcds_data2.namevalue(i,"EMPNO")==gcds_data.namevalue(j,"EMPNO"))){			
                
					ln_Evaseq(j, gcds_data2.namevalue(i,"EVASEQ"), '');
					break;
			    }
			}
		}
	}
</script>

<script language=JavaScript for="gcgd_empno2" event=OnPopup(row,colid,data)>
	ln_FindEmp(colid,row);
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h060013_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
	    <img src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onclick="ln_Chkbox()">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
		  <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> &nbsp;
		</td>
  </tr>
  <!--------------------------------------------------------------------------------> 
  <!------------------------    FORM ����κ�   ------------------------------------> 
  <!--------------------------------------------------------------------------------> 
  <tr> 
    <td COLSPAN=2 width="876" border="6" >
					<table cellpadding="1" cellspacing="0" border="0" width="876px" height="30px" style='font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
								<td width="30px" style="border:0 solid #708090;border-right-width:1px;"bgcolor="#eeeeee"><nobr>&nbsp;������&nbsp;&nbsp;</nobr>
								</td>
								<td  style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp
									<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
										style="position:relative; left:1px;top:3px; width:50px; height:20px; font-family:����; font-size:9pt; "> 
										<param name=Alignment	  value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
								</td>
							<td width="0" align=RIGHT style="height:10px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp�Ҽ�&nbsp;</nobr></td>
							<td width="10px" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
								<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=400 width=150  style="position:relative; top:2px;">
									<param name=ComboDataID           value=gcds_deptcd>
									<param name=SearchColumn          value="DEPTNM">
									<param name=Sort                  value=false>
									<param name=ListExprFormat          value="DEPTNM">       
									<param name=BindColumn              value="DEPTCD"> 
								</object></comment><script>__ws__(__NSID__);</script>			
								&nbsp;&nbsp;</nobr></td>  

							<td width="70px" align=RIGHT style="height:10px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;</nobr></td>
							<td style="height:10px;border:0 solid #708090;border-right-width:1px;">&nbsp;
								<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150   style="position:relative; top:2px;">
									<param name=ComboDataID             value=gcds_paygrd>
									<param name=SearchColumn            value="MINORNM">
									<param name=Sort                    value=false>
									<param name=SortColumn              value="MINORNM">
									<param name=ListExprFormat          value="MINORNM">       
									<param name=BindColumn              value="MINORCD"> 
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td width="70" align=RIGHT style="height:10px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr >&nbsp;����&nbsp;</nobr></td>
							<td style="height:10px;border:0 solid #708090;"><nobr>&nbsp;
								<input  id="txt_name" name="txt_name" type="text"  style="width:120px;t size=20 ; position:relative; left:-5px"  class="txt21" onkeydown="if(event.keyCode==13) ln_Query();"></nobr></td>
							<td width="100%" align=RIGHT style="height:10px;border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr>
							</td>
						</tr>
					</table>
		</td>
  </tr>


  <tr> <td height=3  border="0"> </td> </tr>
  <tr> 
    <td colspan="2" align=LEFT valign=center style="padding-left:0px;"> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=LEFT>
           <div id=gcgd_reresult style="display:block;">
           <table width="876" cellpadding="0" cellspacing="0" border="0">
             <tr> 
                <td  align=LEFT>
								<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_empno  style="WIDTH: 458px;HEIGHT:420px;border:1 solid #777777;">
									<PARAM NAME="DataID"			 VALUE="gcds_data">
									<PARAM NAME="Editable"     VALUE="True">
									<PARAM NAME="BorderStyle"  VALUE="0">
									<param name="Fillarea"		 VALUE="true">
									<PARAM NAME="Sortview"		VALUE="left">
									<param name=ColSizing     value="true">
									<PARAM NAME="Format"		   VALUE="  
									<FC> name='����' ID=CHK  width=30 align=Center  HeadBgColor=#B9D4DC EditStyle=CheckBox  BgColor='#f5f5f5' </FC>
									<FG> Name='�ǰ����'  HeadAlign=Center HeadBgColor=#B9D4DC
										<FC> Name='���'  ID=EMPNO   HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center Edit=none BgColor='#f5f5f5' sort=true</FC>
										<FC> Name='����'  ID=EMPNMK  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=left Edit=none BgColor='#f5f5f5' sort=true</FC>
									</FG>
									<FC> Name='�Ҽ�' ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=105  align=left Edit=none  BgColor='#f5f5f5' sort=true</FC> 
									<C> Name='����' ID=SEQ1 HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left  show=false  </C>
									<C> Name='1��\\�����' ID=EMPNMK1 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='2��\\�����' ID=EMPNMK2 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='3��\\�����' ID=EMPNMK3 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='4��\\�����' ID=EMPNMK4 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='5��\\�����' ID=EMPNMK5 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='6��\\�����' ID=EMPNMK6 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='7��\\�����' ID=EMPNMK7 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='8��\\�����' ID=EMPNMK8 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='9��\\�����' ID=EMPNMK9 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='10��\\�����' ID=EMPNMK10 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='11��\\�����' ID=EMPNMK11 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='12��\\�����' ID=EMPNMK12 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='13��\\�����' ID=EMPNMK13 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='14��\\�����' ID=EMPNMK14 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='15��\\�����' ID=EMPNMK15 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='16��\\�����' ID=EMPNMK16 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='17��\\�����' ID=EMPNMK17 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='18��\\�����' ID=EMPNMK18 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='19��\\�����' ID=EMPNMK19 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='20��\\�����' ID=EMPNMK20 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='21��\\�����' ID=EMPNMK21 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='22��\\�����' ID=EMPNMK22 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='23��\\�����' ID=EMPNMK23 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='24��\\�����' ID=EMPNMK24 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='25��\\�����' ID=EMPNMK25 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='26��\\�����' ID=EMPNMK26 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='27��\\�����' ID=EMPNMK27 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='28��\\�����' ID=EMPNMK28 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='29��\\�����' ID=EMPNMK29 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='30��\\�����' ID=EMPNMK30 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='31��\\�����' ID=EMPNMK31 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='32��\\�����' ID=EMPNMK32 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='33��\\�����' ID=EMPNMK33 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='34��\\�����' ID=EMPNMK34 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='35��\\�����' ID=EMPNMK35 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='36��\\�����' ID=EMPNMK36 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='37��\\�����' ID=EMPNMK37 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='38��\\�����' ID=EMPNMK38 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='39��\\�����' ID=EMPNMK39 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='40��\\�����' ID=EMPNMK40 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='41��\\�����' ID=EMPNMK41 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='42��\\�����' ID=EMPNMK42 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='43��\\�����' ID=EMPNMK43 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='44��\\�����' ID=EMPNMK44 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='45��\\�����' ID=EMPNMK45 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='46��\\�����' ID=EMPNMK46 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='47��\\�����' ID=EMPNMK47 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='48��\\�����' ID=EMPNMK48 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='49��\\�����' ID=EMPNMK49 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='50��\\�����' ID=EMPNMK50 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='51��\\�����' ID=EMPNMK51 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='52��\\�����' ID=EMPNMK52 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='53��\\�����' ID=EMPNMK53 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='54��\\�����' ID=EMPNMK54 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='55��\\�����' ID=EMPNMK55 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
                  <C> Name='56��\\�����' ID=EMPNMK56 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true </C> 
									<C> Name='57��\\�����' ID=EMPNMK57 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='58��\\�����' ID=EMPNMK58 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
	                <C> Name='59��\\�����' ID=EMPNMK59 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C>
									<C> Name='60��\\�����' ID=EMPNMK60 HeadAlign=Center HeadBgColor=#B9D4DC Width=63  align=left Edit=none sort=true</C> 
									">
								 </OBJECT></comment><script>__ws__(__NSID__);</script>
                </td>
            	<td width=3>
                </td>
            	<td>
					<table border="0" cellpadding="0" cellspacing="0" width=410 style=" height:412px;">
					<tr>
						<td  valign=middle style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC"><nobr>&nbsp;���������</nobr></td>
						<td  style="border:0 solid #708090;border-bottom-width:0px;" align=right  colspan=5><nobr>
							<img src="../../Common/img/btn/com_b_reset.gif" style="cursor:hand" onclick="ln_Reset('r')">
							<img src="../../Common/img/btn/com_b_appointment.gif" style="cursor:hand" onclick="ln_Appoint()">
							<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick = "ln_Save()">
							<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick = "ln_Query2()" >&nbsp;</nobr></td>	
					</tr>
					<tr>
						<td width=80 style="height:30px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center><nobr>&nbsp;�����&nbsp;</nobr></td>
						<td  style="border:0 solid #708090;border-top-width:1px;border-left-width:0px;border-bottom-width:0px">&nbsp;&nbsp;
							<input id="txt_empnmkh" type="text" style="width:60px; height:20px; position:relative;left:-12px" disabled="true" class="txt21"><nobr>&nbsp;</nobr>
							<input type="hidden" width="0" id="txt_empnoh">
							<input type="hidden" width="0" id="txt_paygrd">
							<input type="hidden" width="0" id="txt_paygnm">		
							<input type="hidden" width="0" id="txt_deptcd">
							<input type="hidden" width="0" id="txt_deptnm">		
							<input type="hidden" width="0" id="txt_strtdt">		
						</td>		
						<td  style="border:0 solid #708090;border-top-width:1px;border-bottom-width:0px" width="50px;">
							<img src="../../Common/img/btn/com_b_find.gif" alt="����ڸ� �˻��մϴ�" style="position:relative;left:-9px;cursor:hand;" onclick="ln_FindEmp('txt_empnmkh','')"></td>
						<td  width=30  style="height:30px;border:1 solid #708090;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center><nobr>&nbsp;����&nbsp;</nobr></td>
						<td  width=20  style="border:1 solid #708090;border-top-width:1px;border-left-width:0px;border-right-width:0px;border-bottom-width:0px"><nobr>&nbsp;
						<input type="text" style="width:30px;" id="txt_evaseq">
						<!-- 	<comment id="__NSID__"><object id=gclx_evaseq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=50 style = "position:relative;top:3px">
								<param name=CBData               value="  ^  ,1^1��,2^2��,3^3��">
								<param name=CBDataColumns		     value=" Code, Parm">
								<param name=SearchColumn         value="Parm">
								<param name=Sort                 value= false>
								<param name=Index                value="0">
								<param name=ListExprFormat       value="Parm^0^20">       
								<param name=BindColumn            value="Code"> 
							</object></comment><script>__ws__(__NSID__);</script>			
							&nbsp;</nobr> --></td>
						<td width=270 align=RIGHT style="border:1 solid #708090;border-top-width:1px;border-left-width:0px;border-bottom-width:0px"><nobr>&nbsp;</nobr></td>
					</tr>
					<tr>
						<td colspan=6  align=left>
						 <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gcgd_empno2  style="WIDTH:410px; HEIGHT: 360px;border:1 solid #777777;" viewastext>
							 <PARAM NAME="DataID"		    VALUE="gcds_data2">
							 <PARAM NAME="Editable"     VALUE="True">
							 <PARAM NAME="BorderStyle"  VALUE="0">
							 <param name="Fillarea"	    VALUE="true">
							 <PARAM NAME="Sortview"		  VALUE="left">
							 <PARAM NAME="Format"	      VALUE="  
								 <FC>name='����'      ID=CHKOUT  width=30 align=Center HeadBgColor=#B9D4DC EditStyle=CheckBox </FC>
								 <FG>Name='�ǰ����'  HeadAlign=Center HeadBgColor=#B9D4DC
									 <FC> Name='���'   ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55   align=center Edit=none  sort=true </FC> 
									 <FC> Name='����'   ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=left Edit=none sort=true</FC> 
								 </FG>	
								 <FG>Name='�����'  HeadAlign=Center HeadBgColor=#B9D4DC
									 <FC> Name='����'   ID =EMPNMKH HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=left  EditStyle=Popup  sort=true </FC>
									 <FC> Name='����'  ID=EVASEQ  width=10  HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center   Edit=none   sort=true</FC>
										 <C> Name='�Ҽ�' ID=DEPTCD   HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left Edit=none  show=false</C>
										 <C> Name='�Ҽ�' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left Edit=none  sort=true</C>
										 <C> Name='����' ID=PAYGRD   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left Edit=none  show=false</C>	
										 <C> Name='����' ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left Edit=none  sort=true </C>
										 <C> Name='�Ի���' ID=STRTDT  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center Edit=none mask='XXXX/XX/XX' sort=true</C>
									</FG>
									 ">
						   </OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					</table>
                 </td></tr></table></div>
				 </td>
				 </tr>
        </table></td></tr> 

		<tr>
			<td height="24"  style="width:300px"  >��ȸ�Ǽ� : <label id="lbl_search"></label></td>
			<td height="24"  style="position:relative; left:-50px; width:300px;  ">��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
		</tr>	

</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



