/******************************************************************************
	Description : ��������
******************************************************************************/

 var gs_ordno = null ; 
 var gs_inout = 'O' ;  // ����
 var chk01 = "";
 get_cookdata();
 var gs_userid = gusrid;
 var g_dirPath ="";
 
/******************************************************************************
	Description : ���� BODY  LOAD
******************************************************************************/
	function Start_101(dirPath){
	
	    alert("Start_101::"+dirPath);
		
		g_dirPath =dirPath; 
		OnStatusStart(); 
		get_cookdata();
		
		pl_ci_add_div.style.display='none' ;
		ls_start = true ;  
		Start_BasicDataLoad(dirPath);
		ls_start_insert(dirPath) ; 
		ls_insert = true ; 		

		//*img_sts1.style.display = "none"; //�ֹ��˻�
		//*img_rtn.style.display = "none";

		GetParam() ;  // PARAMETER  LOAD  common.js
		
        //alert(" gs_parm[0]::"+ gs_parm[0]);

	  if( gs_parm[0]  == "update"){ // MODE üũ -- �ֹ���������
		order_no.value = gs_parm[1] ; 
		Search(dirPath) ; 
		btn_Edtdt.disabled = true ; 
		btn_cancel.style.display = "none";
		//*img_rtn.style.display = ""; //�ֹ��˻�
		//*img_sts1.style.display = "none";
 
		ChkVal();

		if (gcDs1.NameValue(1,"PL_TYPE") == "Y") {
			pl_cl.checked = true;
			pl_ci_add();
		}
	  } else if (gs_parm[0]  == "update1"){ // MODE üũ) --�ֹ��˻�����
		order_no.value = gs_parm[1] ;  //ORDER NO
		Search(dirPath) ; 
		btn_Edtdt.disabled = true ; 
		btn_cancel.style.display = "none";
		//*img_rtn.style.display = "none";
		//*img_sts1.style.display = ""; //�ֹ��˻�
		ChkVal();
		if (gcDs1.NameValue(1,"PL_TYPE") == "Y") {
			pl_cl.checked = true;
			pl_ci_add();
		}
	  }

	  if (gs_parm[2]=="A") img_sts.style.display = "";
	  else img_sts.style.display = "none";
	  gcDs1.NameValue(1,"DIV_IO") ='N' ;  
	  TheStatusEnd() ;
	}

	/******************************************************************************
		Description : ��û��ü�� ���� �� ���
	******************************************************************************/
	function ChkVal(){
	
		var va1 = new Array("CUST_CDNM","CUST_ID","CUST_PRSN","CUST_TELNO","CUST_HPNO");
		var va2 = new Array("SHIPPER_NM","SHIPPER_ID","SHIPPERPS","SHIPPERTEL","SHIPPERHP");
		var icnt = 0;

		for (var i=0; i<va1.length; i++) {
			if (i==1)	{
				if (eval(va1[i]).text==eval(va2[i]).text) icnt++;
			} else {
				if (eval(va1[i]).value==eval(va2[i]).value) icnt++;
			}
		}
		if (icnt==5) same.checked = true;
	}
	/******************************************************************************
		Description : ���ʵ����� ����
	******************************************************************************/
	function Start_BasicDataLoad(dirPath){ 
		
		//alert("Start_BasicDataLoad");
		gcDs_etc1.DataID = dirPath+"/servlet/transfer.tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project	
		
		//prompt('gcDs_etc1.DataID',gcDs_etc1.DataID);
		//alert("gcDs_etc1.countrow::"+gcDs_etc1.countrow);
		
		gcDs_etc1.Reset();  
			
		gcDs_etc2.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0001";  //��ǰ���� 
		//prompt('',gcDs_etc2.DataID);
		gcDs_etc2.Reset(); 
		
		gcDs_etc3.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0003";  //���籸�� 
		gcDs_etc3.Reset(); 
		 
		gcDs_etc5.DataID = dirPath+"/servlet/transfer.tr00101_s1e4?NOH=Y";  //���籸�� 
		gcDs_etc5.Reset(); 

		gcDs_etc6.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0008";  //���� 
		gcDs_etc6.Reset(); 

		gcDs_etc7.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0008";  //����2(�������庰) 
		gcDs_etc7.Reset(); 

		gcDs_etc8.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc8.Reset();

		gcDs_etc9.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc9.Reset(); 

		gcDs_etc10.DataId = dirPath+"/servlet/transfer.dsProject_s01?v_str1=";
		gcDs_etc10.Reset() ; 

		gcDs_etc11.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc11.Reset();

		gcDs_etc12.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc12.Reset(); 

		gcDs_etc13.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0008";  //���� 
		gcDs_etc13.Reset(); 

		gcDs_samp.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //��ġ����
		gcDs_samp.Reset();

		gcDs_etc15.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc15.Reset();

		gcDs_etc16.DataID = dirPath+"/servlet/transfer.tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc16.Reset();
		
        
	}

	/******************************************************************************
		Description :  START ��� 
	******************************************************************************/
	function ls_start_insert(dirPath) { 
	
		gcDs1.DataId = dirPath+"/servlet/transfer.tr00101_s1?NOH=N";  //MASTER
		//prompt('',gcDs1.DataId);
		gcDs1.Reset();

		gcDs2.DataId = dirPath+"/servlet/transfer.tr00101_sd1?NOH=N"; //DETAIL
		gcDs2.Reset();

		gcDs5.DataId = dirPath+"/servlet/transfer.tr00101_sd1?NOH=N"; //DETAIL
		gcDs5.Reset();

		gcDs4.DataId = dirPath+"/servlet/transfer.tr00101_s2?NOH=N";  //��������
		gcDs4.Reset(); 
		
		CarDetail_Insert();
	}

	/******************************************************************************
		Description :  �űԵ�Ͻ� �⺻ ����
	******************************************************************************/    
	function first_setting() {
		
		gcDs1.AddRow(); 
		//**LINE_PART.index = 0;  
		CARGO_TYPE.index = 0; 
		//**DLVL_TYPE.index = 0; 
				
		gcDs1.NameValue(1,"IN_OUT") = gs_inout;
		gcDs1.NameValue(1,"ORDER_STS") = "0001";//��ϻ��� 
				
	}

	/******************************************************************************
		Description :  UPDATE MODE
	******************************************************************************/
	function Search(dirPath){
	
		gs_ordno = order_no.value;
		
		ls_start = false;

		gcDs1.DataId = dirPath+"/servlet/transfer.tr00101_s1?NOH=Y&gstr1=" +gs_ordno; 
		prompt('gcDs1.DataId',gcDs1.DataId);
		gcDs1.Reset();
		
		//alert("gcDs1.countrow::"+gcDs1.CountRow);

		var sgbn = gcDs1.namevalue(1,"ORDER_STS");

		gcDs2.DataId = dirPath+"/servlet/transfer.tr00101_sd1?NOH=Y&gstr1=" +gs_ordno;
		gcDs2.Reset();

		
		gcDs5.DataId = dirPath+"/servlet/transfer.tr00101_sd1?NOH=N"; 
		gcDs5.Reset();
		//alert("gcDs5.countrow::"+gcDs5.CountRow);


		gcDs4.DataId = dirPath+"/servlet/transfer.tr00101_s2?NOH=Y&gstr1=" +gs_ordno; 
		gcDs4.Reset();
		
		//alert("gcDs4.countrow::"+gcDs4.CountRow);
		
		//dir = dirPath;
	}

	/******************************************************************************
		Description : �ԷºҰ�
	******************************************************************************/
	function SetDisable(){
		//�ֹ�����
		LINE_PART.Enable	= false;
		PROJECT.Enable		= false;
		CARGO_TYPE.Enable = false;
		//**DLVL_TYPE.Enable	= false;
		ETD_DT.Enable			= false;
		ETD_DT1.Enable		= false;
		btn_call_project.disabled = true;
		btn_Edtdt.disabled	= true;
		CONSIGNEE.disabled	= true;
		FAC_PERSON.disabled = true;
		FAC_PRSTEL.disabled = true;
		REMARK.disabled			= true;

		//����
		btn_CarInsert2.style.display	= "none";
		btn_CarDel2.style.display		= "none";
		gcGR0.Editable = false;

		//��ü����
		pl_cl.disabled = true;
		CUST_CD.Enable = false;
		CUST_CDNM.disabled	= true;
		btn_vender.disabled = true;

		CUST_ID.Enable = false;
		SHIPPER.Enable = false;
		CUST_PRSN.disabled	= true;
		CUST_TELNO.disabled = true;
		CUST_HPNO.disabled	= true;
		same.disabled = true;
		SHIPPER_NM.disabled = true;
		SHIPPER_ID.Enable		= false;
		SHIPPERPS.disabled	= true;
		SHIPPERTEL.disabled = true;
		SHIPPERHP.disabled	= true;

		// P/L & C/I
		// ������
		PL_SHIPPER.disabled			= true;
		btn_calshipper.disabled = true;
		PL_SHPPRNM.disabled			= true;
		PL_SHIPADDR.disabled		= true;
		PL_SHPADDR2.disabled		= true;
		PL_SHPADDR3.disabled		= true;
		PL_SHIPTEL.disabled			= true;
		//������
		PL_CSTM.disabled				= true;
		btn_calcsi.disabled		= true;
		PL_CSTMNM.disabled		= true;
		PL_CSTADDR.disabled		= true;
		PL_CSTADDR2.disabled	= true;
		PL_CSTADDR3.disabled	= true;
		PL_CSTTEL.disabled		= true;
		//����ó
		PL_BRKR.disabled			= true;
		btn_calbrkr.disabled	= true;
		PL_BRKRNM.disabled		= true;
		PL_BRKADDR.disabled		= true;
		PL_BRKADDR2.disabled	= true;
		PL_BRKADDR3.disabled	= true;
		PL_BRKTEL.disabled		= true;
		//��ǥ��ǰ
		RPST_GOODS.disabled = true;
		//��Ź��
		PL_CSN.disabled				= true;
		btn_calcs.disabled		= true;
		PL_CSNNM.disabled			= true;
		PL_CSNADDR.disabled		= true;
		PL_CSNADDR2.disabled	= true;
		PL_CSNADDR3.disabled	= true;
		PL_CSNTEL.disabled		= true;
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1);
		obj.NameValue(1,"MINORCD")  = "";
		obj.NameValue(1,"MINORNM")  = "=���� or �Է�=";
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoiceProjct(obj){
		obj.InsertRow(1);
		obj.NameValue(1,"TR_PROJECT") = "";
		obj.NameValue(1,"USE_PROJNM") = "=���� or �Է�=";
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoiceCar(obj){
		obj.InsertRow(1);
		obj.NameValue(1,"CAR_TYPE" )  = "";
		obj.NameValue(1,"CAR_NAME" )  = "=���� or �Է�=";
	}  

	/******************************************************************************
		Description :  2�ܰ� �̵�
	******************************************************************************/
	function show_detail(step){
		//alert("show_detail"+step);
		if(step == "1" ) {
			if (confirm("�������� ��ǰ������ ���� �˴ϴ�. \n\n�ֹ������� �̵��Ͻðڽ��ϱ� ?  "))	{
				step1.style.display = ""; 
				if(pl_cl.checked == true) pl_ci_add_div.style.display = "";
				step2.style.display = "none";
				gcDs2.Reset();
			}
		} else if(step == "2" ) {
			dispStep2();
			
			pl_ci_add_div.style.display = "none";
			step1.style.display = "none";
			step2.style.display = "";

			var ls_typ = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
			if (ls_typ == "0002")	disp_confirm.style.display = "none";
			else {
				if (gcDs4.countrow<2) disp_confirm.style.display = "none";
				else {
					if (gn_ShowStep2()) disp_confirm.style.display = "none";
					else disp_confirm.style.display = "";
				}
			}
		} 
	}
		
	/******************************************************************************
		Description : ��Ź���� ���ɿ��� ����
	******************************************************************************/
	function gn_ShowStep2(){
		var ls_chk = true;
		for (var k=1; k<=gcDs4.countrow ; k++) {
			if (gcDs4.namevalue(1,"LD_CARGO")!=gcDs4.namevalue(k,"LD_CARGO")) ls_chk = false;
		}

		if (gcDs4.countrow>1) ls_chk = false;

		return ls_chk;
	}

	/******************************************************************************
		Description :  �����ڵ� ��������(������ �δ�)
	******************************************************************************/
	function call_project(e){
		strURL = "TR00102_E1.html";
		var myW = 400;
		var myH = 425;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,e,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

		if(PopWinValue != null ) gcDs1.NameValue(1,"PROJECT")  = PopWinValue[0];
	}

	/******************************************************************************
		Description :  Packing List & Commercial Invoice ��û
	******************************************************************************/
	function pl_ci_add(){
		if(pl_cl.checked ==false){
			/////pl_ci_add_div.style.display	 = "none";
			gcDs1.NameValue(1,"PL_TYPE") = "N";
		}	else {
			////pl_ci_add_div.style.display  = "block";
			gcDs1.NameValue(1,"PL_TYPE") = "Y";
		}
	}

	/******************************************************************************
		Description :  �ŷ�ó Ȯ�� : ����ڹ�ȣ
	******************************************************************************/
	function CheckCustCd(){
		gcDs_4etc.DataId = "";
		gcDs_4etc.Reset();
	}

	/******************************************************************************
		Description :  �ŷ�ó�ڵ�
	******************************************************************************/  
	function call_vender(obj,objtype){
		strURL = "TR00102_E3.html";
		var myW = 400;
		var myH = 420;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		var ls_param = "";
		if (obj=="CUST_CD") ls_param = CUST_CDNM.value;
		else if (obj=="SHIPPER") ls_param = SHIPPER_NM.value;
		
		if (ls_param=="")	PopWinValue = window.showModalDialog(strURL,'',"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
		else PopWinValue = window.showModalDialog(strURL,ls_param,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

		if(PopWinValue != null ){
			if(obj =="CUST_CD" ) {	
				gcDs1.NameValue(1,obj)  = PopWinValue[0];  
				CUST_CD.Text =  PopWinValue[0];
				CUST_CDNM.value =PopWinValue[1];
				CUST_PRSN.value= PopWinValue[2];
				CUST_TELNO.value= PopWinValue[4];
				CUST_HPNO.value= PopWinValue[5]; 
				CUST_ID.Text =  PopWinValue[9];
			} else if (obj =="SHIPPER" ) {
				gcDs1.NameValue(1,obj)  = PopWinValue[0];  
				eval( obj +"."+ objtype + "=PopWinValue[0];" );  
				SHIPPER_NM.value =PopWinValue[1];
				SHIPPERPS.value= PopWinValue[2]; 
				SHIPPERTEL.value= PopWinValue[4];
				SHIPPER_ID.Text =  PopWinValue[9];
			} else if (obj =="CAR_CUST_CD" ) {
				eval( obj +"."+ objtype + "=PopWinValue[0];" );  
				CAR_CUST_NAME.value =PopWinValue[1];  
				CUST_PS.value =  PopWinValue[2]; 
				CUST_TEL.value = PopWinValue[4];
			}
		}
	}

	/******************************************************************************
		Description : Call  NameCheck - �ŷ�ó 
	******************************************************************************/ 
	function nameCheck_cust(obj){
		var  ls_value = eval(obj+".value"); 

		if(  strim(ls_value) == "" ) return false; 

		gcDs_2etc.DataID = g_dirPath+"/servlet/transfer.tr00101_s1e3?NOH=Y&gstr1=&gstr2="+strim(ls_value); 
		//prompt('gcDs_2etc.DataID',gcDs_2etc.DataID);
		gcDs_2etc.Reset();

		if (gcDs_2etc.countrow<2) Return_nameCheck_cust();
		else {
			if (obj=="CUST_CDNM") call_vender("CUST_CD","Text");
			else if (obj=="SHIPPER_NM") call_vender("SHIPPER","Text");
		}
	}

	/******************************************************************************
		Description :  Return  NameCheck - �ŷ�ó 
	******************************************************************************/ 
	function Return_nameCheck_cust(){
		if(gcDs_2etc.CountRow > 0 ) {
			if (gcDs_2etc.countrow==1) {
				gcDs1.NameValue(1,"CUST_CD") = gcDs_2etc.NameValue(1,"VEND_CD") ; 
				CUST_CD.Text = gcDs_2etc.NameValue(1,"VEND_CD") ; 
				CUST_PRSN.value= gcDs_2etc.NameValue(1,"VEND_PRS") ; 
				CUST_TELNO.value= gcDs_2etc.NameValue(1,"VEND_TEL") ; 
			}
		}	else {
			alert("�Է��Ͻ� �ŷ�ó�� �̸��� �������� �ʽ��ϴ�. :  ���Է�" );
			CUST_CDNM.Text = "" ; 
			CUST_CDNM.value = "" ; 
			CUST_PRSN.value = ""; 
			CUST_TELNO.value = ""; 
		} 
	}

	/******************************************************************************
		Description :  ��û��ü�� ȭ�� ����
	******************************************************************************/     
	function Shipper_Same() {
		if(same.checked == true ) {
			gcDs1.NameValue(1,"SHIPPER") = gcDs1.NameValue(1,"CUST_CD");
			SHIPPER.Text = CUST_CD.Text;
			SHIPPER_NM.value = CUST_CDNM.value;
			SHIPPERPS.value = CUST_PRSN.value;
			SHIPPERTEL.value = CUST_TELNO.value;
			SHIPPERHP.value = CUST_HPNO.value;
			SHIPPER_ID.text = CUST_ID.text;
		}
	}

	/******************************************************************************
		Description :  Master DataCheck
	******************************************************************************/     
	function Master_DataCheck(){ 
		if(LINE_PART.bindcolval == "" ) {
			alert("Project ����"); 
			return false;
		} 

		if(LINE_PART.index != 3) {
			if( PROJECT.index == 0 ) {
				alert("������ �δ� ����"); 
				return false;
			}
		}

		if(strim(ETD_DT.Text) == "" ) {
			alert("�������� ����"); 
			return false;
		}

		if(strim(txt_obj_remk.value) == "" ) {
			alert("���Ը���/���� ����"); 
			return false;
		}
		
		/**
		if (DLVL_TYPE.bindcolval!="0001")	{
			if(strim(FAC_PERSON.value) == "" || strim(FAC_PRSTEL.value) == "") {
				alert("������������ ����"); 
				return false;
			}
		}
		**/

		if(strim(CUST_CD.Text) == "" ) {
			alert("��û��ü ����"); 
			return false;
		} 

		if(strim(CUST_PRSN.value) == "" ) {
			alert("��û��ü ����� ����"); 
			return false;
		}

		if(strim(CUST_TELNO.value) == "" ) {
			alert("��û��ü ��ȭ��ȣ ����"); 
			return false;
		} 

		if(strim(SHIPPER.Text) == "" ) {
			alert("��ȭ�� ����"); 
			return false;
		}

		if(strim(SHIPPERPS.value) == "" ) {
			alert("��ȭ�� ����� ����");
			return false;
		}

		if(strim(SHIPPERTEL.value) == "" ) {
			alert("��ȭ�� ��ȭ��ȣ ����");
			return false;
		}

		if(CARGO_TYPE.bincolval == "" ) {
			alert("���籸�� ����"); 
			return false;
		}

		for (var i=1; i<=gcDs4.countrow; i++) {
			if (strim(gcDs4.namevalue(i,"CARTYPENO"))=="")	{
				alert("�������� (����) ����");
				return false;
				break;
			}

			if (strim(gcDs4.namevalue(i,"CTN_STDRD"))=="")	{
				alert("�������� (��ǥǰ��) ����");
				return false;
				break;
			}

			if (strim(gcDs4.namevalue(i,"LD_CARGO"))=="")	{
				alert("�������� (������) ����");
				return false;
				break;
			}

			if (strim(gcDs4.namevalue(i,"OFF_CARGO"))=="")	{
				alert("�������� (������) ����");
				return false;
				break;
			}
		}

		return true ; //���� �� ���� �Ѱ��� ������
	}

	/******************************************************************************
		Description :  Master  ---- >Text box
	******************************************************************************/  
	
	function Match_master(){ 
		
		gcDs_etc.DataId = g_dirPath+"/servlet/transfer.tr00101_s1e3?NOH=Y&gstr1=" + gcDs1.NameValue(1,"CUST_CD");
		gcDs_etc.Reset();		
		CUST_CDNM.value = gcDs_etc.NameValue(1,"VEND_NM");

		gcDs_etc.DataId = g_dirPath+"/servlet/transfer.tr00101_s1e3?NOH=Y&gstr1=" + gcDs1.NameValue(1,"SHIPPER");
		gcDs_etc.Reset();
		SHIPPER_NM.value = gcDs_etc.NameValue(1,"VEND_NM");
		
		gcDs_etc.DataId = g_dirPath+"/servlet/transfer.tr00101_s1e1?NOH=Y&gstr1=&gstr2=" + gcDs1.NameValue(1,"PROJECT");
		gcDs_etc.Reset();
	}

	/******************************************************************************
		Description : ���� ���� �Է°� Ȯ��
	******************************************************************************/     
	function gn_ChkCar(){
		var k=0;

		var ls_gbn = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
		if (ls_gbn != "0002")	{
			if (gcDs4.countrow<1) {
				alert("���������� �Է��� �ֽʽÿ�.");
				return false;
			}

			if (gcDs4.sysStatus(1)!="0") {
				alert("���������� �����Ͽ� �ֽʽÿ�.");
				return false;
			} 
		}

		return true;
	}

	/******************************************************************************
		Description :  Master �����ϱ�
	******************************************************************************/     
	function Master_Save(){

		if(!Master_DataCheck()) return false;
		
		if(ls_start == true){
			var ls_yymm =  ETD_DT.Text.substring(2,6);
			gcDs_etc0.DataID = g_dirPath+"/servlet/transfer.dsGetSeqNo?NOH=Y&gstr1=0001&gstr2=" + ls_yymm;  // �ֹ���ȣ Load
			//prompt('gcDs_etc0.DataID',gcDs_etc0.DataID );
			gcDs_etc0.Reset();   
			gs_ordno = 'O' + ls_yymm +  gcDs_etc0.NameValue(1,"SEQ_NO");
			//alert("gs_ordno::"+gs_ordno);
		}

		var sval = gcDs1.NameValue(1,"PL_TYPE");
		sval = strim(sval);
		if (sval!="Y") gcDs1.NameValue(1,"PL_TYPE") = "N";

		var ls_date = gcDs1.namevalue(1,"ETD_DT");
		var ls_part = gcDs1.namevalue(1,"LINE_PART");

		//alert("Master_Save:::trOrderRegMst:;");
		gcTr01.KeyValue = "trOrderRegMst(I:USER=gcDs1)";
		gcTr01.Action = g_dirPath+"/servlet/transfer.trOrderRegMst";
		gcTr01.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ 
		//prompt('gcDs1',gcDs1.text );
		gcTr01.post();

		var ls_gbn = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
		//alert("ls_gbn:;"+ls_gbn);
		if (ls_gbn != "0002")	{
			for (var s=1;s<=gcDs4.countrow ; s++) {
				if (gcDs4.sysStatus(s)=="1") {
					gcDs4.NameValue(s,"EDT_DATE")	= ls_date;
					gcDs4.NameValue(s,"LINE_PART")	= ls_part;
					gcDs4.namevalue(s,"ORDER_NO")	= gs_ordno;
					gcDs4.namevalue(s,"CREATE_USR") = gusrid;
				}
			}

			gcTr03.KeyValue = "trOrderCar(I:USER=gcDs4)";
			gcTr03.Action = g_dirPath+ "/servlet/transfer.trOrderCar";
			gcTr03.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ
			//prompt('gcDs4:',gcDs4);
			gcTr03.post();
		} else show_detail('2');

		ls_start = false ; 

		return true ;  
	}

	var tid = "";
	/******************************************************************************
		Description :  step �̵�
	******************************************************************************/  
	function dispStep2(){ 
		if(gcDs2.CountRow == 0 ) New_Insert();

		if(CARGO_TYPE.BindColVal != "0002")	disp_carbutton.style.display = ""; 
		else disp_carbutton.style.display = "none" ; 

		if(LINE_PART.BindColVal == "0002") gcGR1.columnProp("ENG_ARTCNM","Show") = true; 
		else gcGR1.columnProp("ENG_ARTCNM","Show") = false; 

	}

	/******************************************************************************
		Description :  ��ǰ�ڵ�
	******************************************************************************/  
	function call_artc(obj){
		strURL = "TR00102_E4.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			ARTC_CD.value = PopWinValue[0]; 
			ARTC_NM.value = PopWinValue[1];  
		}
	}

	/******************************************************************************
		Description :  Detail ���� ��� ����
	******************************************************************************/  
	function New_Insert() {

		ls_insert = true ; //�űԼ���

		var sseq = gcDs2.Namevalue(gcDs2.countrow,"ORDER_SEQ");

		gcDs2.Addrow();

		var row2 = gcDs2.rowposition;

		if (gcDs2.countrow==1) gcDs2.namevalue(1,"ORDER_SEQ") = 1;
		else {
			sseq = parseInt(sseq,10) + 1;
			gcDs2.namevalue(row2,"ORDER_SEQ") = sseq ;
		}

		gcDs2.namevalue(row2,"LDCARGO") = gcDs4.namevalue(1,"LD_CARGO");
		gcDs2.namevalue(row2,"OFFCARGO") = gcDs4.namevalue(1,"OFF_CARGO");
		gcDs2.namevalue(row2,"ARTC_CNT") = 1;

		var gbnval = new Array( "GBN_LDCARGO","GBN_OFFCARGO","GBN_ENG_ARTCNM","GBN_HSCODE",//"GBN_HSCODENM",
														"GBN_ARTC_NM","GBN_STN_SZNM","GBN_ARTC_UNIT","GBN_ARTC_CNT","GBN_UNIT_PRICE",
														"GBN_PRICE","GBN_CUR_CODE","GBN_FR_UNTPRCE","GBN_FR_PRICE","GBN_PUNIT_CNT",
														"GBN_PUNIT_WGHT","GBN_PKG_LNGTH","GBN_PKG_WIDTH","GBN_PKG_HEIGHT","GBN_PKG_CBM",
														"GBN_PKG_CNT","GBN_LDCARGONM","GBN_OFFCARGONM","GBN_MIX_OTHERS","GBN_SAMEAS"
													);
		for (var k=0; k<gbnval.length; k++ ) gcDs2.namevalue(row2,gbnval[k]) = "N";
	}

	/******************************************************************************
		Description :  HSCODE Call
	******************************************************************************/  
	function call_hscode(){
		strURL = "hs_code.html";
		PopupOpenDialog(850,490);

		if(PopWinValue != null ){
			gcDs2.namevalue(gcDs2.rowposition,"HSCODE") = PopWinValue[0]; 
			gcDs2.namevalue(gcDs2.rowposition,"HSCODENM") = PopWinValue[1]; 
		}
	}

	/******************************************************************************
		Description :  �ݾװ��
	******************************************************************************/   
	function getPrice(){
		var ls_cnt =  ARTC_CNT.Text;
		var ls_unit_price =  UNIT_PRICE.Text;

		if(ls_cnt !=null && ls_cnt !="" && ls_unit_price !=null && ls_unit_price !="") PRICE.Text = ls_cnt * ls_unit_price;
	}

	/******************************************************************************
		Description : CBM���
	******************************************************************************/   
  function calPKGCnt(){
		if(strim(PUNIT_CNT.Text) != "" && strim(PUNIT_CNT.Text) != 0 && strim(ARTC_CNT.Text) != "" && strim(ARTC_CNT.Text) != 0 ){
			var cnt =  ARTC_CNT.Text;
			var unitcnt =   PUNIT_CNT.Text;
			PKG_CNT.Text =  cnt / unitcnt;

			getWeight();

			if(	strim(PKG_CNT.Text) != "" ) {
				TOTAL_PKG_CBM.Text =  PKG_CNT.Text * PKG_CBM.Text;
	    }
		} 
	}

	/******************************************************************************
		Description : �߷����
	******************************************************************************/   
	function getWeight(){
		if(strim(PKG_CNT.Text)!="" && strim(PUNIT_WGHT.Text) != null)	{
			PKG_WGHT.Text = PKG_CNT.Text * PUNIT_WGHT.Text;
		}
	}

	/******************************************************************************
		Description :  CBM���
	******************************************************************************/    
	function get_cbm(){
		ls_unitlength = PKG_LNGTH.Text ; 
		ls_unitwidth  =  PKG_HEIGHT.Text ; 
		ls_unitheight =   PKG_WIDTH.Text ;  
		PKG_CBM.Text = ls_unitlength* ls_unitwidth * ls_unitheight /1000000; 
		if(	 strim(PKG_CNT.Text)  != "" )	{
			TOTAL_PKG_CBM.Text = PKG_CNT.Text * PKG_CBM.Text;
		}
	}
 
	/******************************************************************************
		Description :  CBM���
	******************************************************************************/  
	function DetailBinding() {		 
		if(! Detail_DataCheck() ){return false ; }
		if(ls_insert == true ){  //�űԵ�� üũ
			saveing = true ; 
		}
	
		gcDs2.NameValue(gcDs2.RowPosition,"REGFILE") = FILENAME.value ; 
		var tmaifname = ln_Divide(FILENAME.value, "\\");
		gcDs2.NameValue(gcDs2.RowPosition,"REGFILENAME") = tmaifname ; 
		saveing = false ; 

		return true ; 
	} 

	/******************************************************************************
		Description :  Detail ������ ��Ī
	******************************************************************************/     
	function Detail_Save(){
	
	    //alert("Detail_Save 1");
		if(!DetailBinding() ){ return false ;}

		//alert("Detail_Save 2");
		if (gcDs2.UseChangeInfo){
			//alert("Detail_Save 21");
			var parm = "";
			var t = 1;
			for (var s=1; s<=gcDs2.countrow; s++) {
				if (gcDs2.sysStatus(s)=="3") {
					if (t==1) {
						parm = "'" + gcDs2.namevalue(s,"ORDER_SEQ") + "'";
						t++;
					} else {
						parm += ",'" + gcDs2.namevalue(s,"ORDER_SEQ") + "'";
						t++;
					}
				}
			}

			if (strim(parm)!="") {
				gcds_chk.DataID = g_dirPath+"/servlet/transfer.tr00102_s2?v_str1=" + gcDs2.namevalue(row,"ORDER_NO") + "&v_str2=" + parm ;
				gcds_chk.Reset();

				if (gcds_chk.namevalue(1,"CNT")>0) {
					if (!confirm("�����ڷᰡ �����մϴ�. ��� �����Ͻðڽ��ϱ� ?  "))	{
						return;
					}
				}
			}
			
			//alert("Detail_Save 3");

			gcDs5.UndoAll();
			for (var k=1; k<=gcDs2.countrow; k++) {
				if (gcDs2.sysStatus(k)=="1")	{
					gcDs5.Addrow();
					var row = gcDs5.rowposition;
					for (var j=1; j<=gcDs2.countColumn; j++) {
						gcDs5.namevalue(row,gcDs2.columnid(j)) = gcDs2.namevalue(k,gcDs2.columnid(j));
					}
					var ls_cargo_type = CARGO_TYPE.bindcolval;
					if (ls_cargo_type == "0003" || ls_cargo_type == "0004") {
						gcDs5.namevalue(row,"PUNIT_CNT") = 1;
						gcDs5.namevalue(row,"PKG_CNT") = 1;
					}
				}
			}

			for (var k=1; k<=gcDs2.countrow; k++) {
				if (gcDs2.sysStatus(k)=="3")	{
					gcDs5.Addrow();
					var row = gcDs5.rowposition;
					for (var j=1; j<=gcDs2.countColumn; j++) {
						gcDs5.namevalue(row,gcDs2.columnid(j)) = gcDs2.namevalue(k,gcDs2.columnid(j));
					}
					gcDs5.namevalue(row,"CREATE_USR") = gusrid;
					gcDs5.userStatus(row) = "3";
				}
			}
		} else {
			
			//alert("Detail_Save 4");
			
			gcDs5.UndoAll();
			for (var k=1; k<=gcDs2.countrow; k++) {
				gcDs5.Addrow();
				var row = gcDs5.rowposition;
				for (var j=1; j<=gcDs2.countColumn; j++) {
					gcDs5.namevalue(row,gcDs2.columnid(j)) = gcDs2.namevalue(k,gcDs2.columnid(j));
				}
				var ls_cargo_type = CARGO_TYPE.bindcolval;
				if (ls_cargo_type == "0003" || ls_cargo_type == "0004") {
					gcDs5.namevalue(row,"PUNIT_CNT") = 1;
					gcDs5.namevalue(row,"PKG_CNT") = 1;
				}
				gcDs5.namevalue(row,"ORDER_NO") = "";
			}
		}

		var ls_filename = gcDs2.NameValue(gcDs2.RowPosition,"REGFILENAME") ; 
		if (ls_filename==null) ls_filename = "";

		var pltype = "N";
		if (same.checked == true) pltype = "Y";

		if( strim(ls_filename) == "")	gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtl"; 
		else gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtlAddFile"; 
	
		gcTr02.KeyValue = "trOrderRegDtl(I:USER=gcDs5)";
		gcTr02.Parameters = "gstr1=" + gs_ordno + ",gstr2=" + ETD_DT.text + ",gstr3=" + pltype; //�ֹ���ȣ 
		
		//prompt('gcDs5', gcDs5.text);
		gcTr02.post(); 
	
		gcDs2.UseChangeInfo = true;
		gcDs5.UseChangeInfo = true;

	}
/*function Detail_Save(){
		if(!DetailBinding() ){ return false ;}

		var parm = "";
		var t = 1;
		for (var s=1; s<=gcDs2.countrow; s++) {
			if (gcDs2.sysStatus(s)=="3") {
				if (t==1) {
					parm = "'" + gcDs2.namevalue(s,"ORDER_SEQ") + "'";
					t++;
				} else {
					parm += ",'" + gcDs2.namevalue(s,"ORDER_SEQ") + "'";
					t++;
				}
			}
		}

		if (strim(parm)!="") {
			gcds_chk.DataID = "/servlet/transfer.tr00102_s2?v_str1=" + gcDs2.namevalue(row,"ORDER_NO") + "&v_str2=" + parm ;
			gcds_chk.Reset();

			if (gcds_chk.namevalue(1,"CNT")>0) {
				if (!confirm("�����ڷᰡ �����մϴ�. ��� �����Ͻðڽ��ϱ� ?  "))	{
					return;
				}
			}
		}

		gcDs5.UndoAll();

		for (var k=1; k<=gcDs2.countrow; k++) {
			if (gcDs2.sysStatus(k)=="1")	{
				gcDs5.Addrow();
				var row = gcDs5.rowposition;
				for (var j=1; j<=gcDs2.countColumn; j++) {
					gcDs5.namevalue(row,gcDs2.columnid(j)) = gcDs2.namevalue(k,gcDs2.columnid(j));
				}
			}
		}

		for (var k=1; k<=gcDs2.countrow; k++) {
			if (gcDs2.sysStatus(k)=="3")	{
				gcDs5.Addrow();
				var row = gcDs5.rowposition;
				for (var j=1; j<=gcDs2.countColumn; j++) {
					gcDs5.namevalue(row,gcDs2.columnid(j)) = gcDs2.namevalue(k,gcDs2.columnid(j));
				}
				//gcDs5.userStatus(row) = "3";

				gcDs5.namevalue(row,"CREATE_USR") = gusrid;
					gcDs5.userStatus(row) = "3";
			}
		}

		gcTr02.KeyValue = "trOrderRegDtl(I:USER=gcDs5)";
		var ls_filename = gcDs2.NameValue(gcDs2.RowPosition,"REGFILENAME") ; 
		if (ls_filename==null) ls_filename = "";

		if( strim(ls_filename) == "")	{
			gcTr02.Action = "/servlet/transfer.trOrderRegDtl"; 
		//	gcTr02.Parameters = "gstr1="+gs_ordno +",gstr2=" + "200602" ; //�ֹ���ȣ 
			gcTr02.Parameters = "gstr1=" + gs_ordno + ",gstr2=" + ETD_DT.text ;//+ ",gstr3=" + pltype; //�ֹ���ȣ

		//	var ls_date = gcDs1.namevalue(1,"ETD_DT");
		//	gcDs4.NameValue(s,"EDT_DATE")		= ls_date;


			//gcTr02.Parameters = "gstr1=" + gs_userid +",gstr2=" + gs_userid + ",v_str3=" ;

alert(gcTr02.Parameters);
		}else gcTr02.Action = "/servlet/transfer.trOrderRegDtlAddFile"; 
		
		prompt('', gcDs5.Text);
		gcTr02.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ 
	//	gctr_code01.Parameters = "v_str1=" + gs_userid +",v_str2=" + gs_userid + ",v_str3=" ;

		gcTr02.post(); 
		gcDs2.Reset();
	}
*/
	/******************************************************************************
		Description :  Detail ������ ����
	******************************************************************************/     
	function Detail_Delete(){
		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
			var sFlag = "Y";
			for (var k=1 ;k<=gcDs2.countrow ;k++ ) {
				if (gcDs2.sysStatus(k)=="1"){
					alert("�ű� �ۼ��Ͻ� ������ �ֽ��ϴ�. \n\n�����Ͻ� �� �����Ͻ� ������ �����Ͽ� �ֽʽÿ�.  ");
					sFlag = "N";
					break;
				}
				if (gcDs2.sysStatus(k)=="3"){
					alert("�����Ͻ� ������ �ֽ��ϴ�. \n\n�����Ͻ� �� �����Ͻ� ������ �����Ͽ� �ֽʽÿ�.  ");
					sFlag = "N";
					break;
				}
			}

			if (sFlag == "N") return;

			gcds_chk.DataID = g_dirPath+"/servlet/transfer.tr00102_s2?v_str1=" + gcDs2.namevalue(row,"ORDER_NO") + "&v_str2=" + gcDs2.namevalue(row,"ORDER_SEQ");
			gcds_chk.Reset();

			if (gcds_chk.namevalue(1,"CNT")>0) {
				if (!confirm("�����ڷᰡ �����մϴ�. ��� �����Ͻðڽ��ϱ� ?  "))	{
					return;
				}
			}

			var org1 = gcDs2.OrgNameValue(row,"ORDER_SEQ");
			var org2 = gcDs2.OrgNameValue(row,"SAMEAS");

			if (org1==org2)	{
				if (confirm("�������� ������ �����մϴ�.\n\n�����Ͻ� ������ �����Ͻðڽ��ϱ� ?  ")) {
					gcDs2.deleterow(row);

					gcTr02.KeyValue = "trOrderRegDtl(I:USER=gcDs2)";
					var ls_filename = gcDs2.NameValue(gcDs2.RowPosition,"REGFILENAME");

					if( strim(ls_filename) == "") gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtl"; 
					else gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtlAddFile"; 
					
					gcTr02.Parameters = "gstr1=A"; //���������� ���
					gcTr02.post(); 
					gcDs2.Reset() ;  
				}
			} else {
				if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					gcDs2.deleterow(row);
					gcTr02.KeyValue = "trOrderRegDtl(I:USER=gcDs2)";

					var ls_filename = gcDs2.NameValue(gcDs2.RowPosition,"REGFILENAME");
					if (ls_filename==null) ls_filename = "";

					if (strim(ls_filename) == "") {
						gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtl"; 
					} else {
						gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtlAddFile"; 
					}

					gcTr02.Parameters = "gstr1=B"; //���������� ���
					gcTr02.post(); 
					gcDs2.Reset();
				}
				
			}
		}
	}

	/******************************************************************************
		Description : 
	******************************************************************************/     
	function Detail_DataCheck(){
		var row = gcDs2.rowposition;
		var lartc_nm = gcDs2.NameValue(row,"ARTC_NM");

		if (strim(lartc_nm) == "" ){
			alert("ǰ�� ����");
			return false;
		} 

		var lartc_cnt = gcDs2.NameValue(row,"ARTC_CNT");
		if (lartc_cnt == 0 ){
			alert("���� ����");
			return false;
		}

		var l_unit_price = gcDs2.NameValue(row,"UNIT_PRICE");
		if(l_unit_price == 0 ){
			alert("�ܰ� ����");
			return false;
		}  

		var ls_project = LINE_PART.ValueOfIndex("MINORCD", LINE_PART.index);
		var ls_eng_artcnm = gcDs2.namevalue(gcDs2.rowposition,"ENG_ARTCNM")
		if(strim(ls_eng_artcnm) == "" && ls_project == "0002" ){
			alert("����ǰ�� ���� -�ݰ��� ");
			return false;
		} 

		return true ; 
	}

 /******************************************************************************
		Description :  Check Detail ���� // ù��° ������ �������� ����Ȯ��
	******************************************************************************/    
	function Check_Detail_firstRow() {	
		var ls_punit_cnt = trim(gcDs2.NameValue ( 1,"PUNIT_CNT" )); //��������� ����
		if( ls_punit_cnt == "" ||  ls_punit_cnt == null || ls_punit_cnt == 0 ){alert("�������庰-���� ����"); return false ; }
		
		var ls_punit_wght = trim(gcDs2.NameValue ( 1,"PUNIT_WGHT" )) ;//��������� �߷� 
		if( ls_punit_wght == "" ||  ls_punit_wght == null || ls_punit_wght == 0 ){alert("�������庰-�߷� ����"); return false ; }

		var ls_pkg_lngth = trim(gcDs2.NameValue ( 1,"PKG_LNGTH" )); //��������� ���� 
		if( ls_pkg_lngth == "" ||  ls_pkg_lngth == null || ls_pkg_lngth == 0 ){alert("�������庰- ���� ����"); return false ; } 

		var ls_pkg_height = trim(gcDs2.NameValue ( 1,"PKG_HEIGHT" )); //��������� ����
		if( ls_pkg_height == "" ||  ls_pkg_height == null || ls_pkg_height == 0 ){alert("�������庰- ���� ����"); return false ; }

		var ls_pkg_width = trim(gcDs2.NameValue ( 1,"PKG_WIDTH" )); //��������� ����
		if( ls_pkg_width == "" ||  ls_pkg_width == null || ls_pkg_width == 0 ){alert("�������庰- �� ����"); return false ; }
		 
		var ls_pkg_cnt = trim(gcDs2.NameValue ( 1,"PKG_CNT" )); //��������� �Ѽ���
		if( ls_pkg_cnt == "" ||  ls_pkg_cnt == null || ls_pkg_cnt == 0 ){alert("�������庰- �Ѽ��� ����"); return false ; } 

		return true ; 
	}

	/******************************************************************************
		Description :  Check Detail ����
	******************************************************************************/    
	function Check_Detail() {	
		if(gcDs2.CountRow < 1 ) alert("Ȯ�� : ��ǰ������ �Ѱ��̻� ��ϵǾ�� �մϴ�.") ; 
	
		Check_Detail_firstRow() ;  //ù��° ������ �������� ����Ȯ��
	} 

	/******************************************************************************
		Description :  ��ǰ ���� �� -- > Text Box
	******************************************************************************/    
	function DataSet_ToText(){
		var ls_row = gcDs2.Rowposition ;  
		DTL_LD_CAR.index			= DTL_LD_CAR.IndexOfColumn("MINORCD",gcDs2.NameValue(ls_row,"LDCARGO"));
		DTL_OFF_CAR.index			= DTL_OFF_CAR.IndexOfColumn("MINORCD",gcDs2.NameValue(ls_row,"OFFCARGO"));
		DTL_LD_CAR_NM.value		= gcDs2.NameValue(ls_row,"LDCARGONM");
		DTL_OFF_CAR_NM.value	= gcDs2.NameValue(ls_row,"OFFCARGONM");
		ARTC_UNIT.index				= ARTC_UNIT.IndexOfColumn("MINORCD",gcDs2.NameValue(ls_row,"ARTC_UNIT"));
		ARTC_NM.value					= gcDs2.NameValue(ls_row,"ARTC_NM");
		ARTC_CD.value					= gcDs2.NameValue(ls_row,"ARTC_CD");
		STN_SZNM.value				= gcDs2.NameValue(ls_row,"STN_SZNM");
		HSCODE.value					= gcDs2.NameValue(ls_row,"HSCODE");
		ARTC_CNT.Text					= gcDs2.NameValue(ls_row,"ARTC_CNT");
		UNIT_PRICE.Text				=	gcDs2.NameValue(ls_row,"UNIT_PRICE");
		PRICE.Text						= gcDs2.NameValue(ls_row,"PRICE");
		PUNIT_CNT.Text				= gcDs2.NameValue(ls_row,"PUNIT_CNT");
		PUNIT_WGHT.Text				= gcDs2.NameValue(ls_row,"PUNIT_WGHT");
		PKG_LNGTH.Text				= gcDs2.NameValue(ls_row,"PKG_LNGTH");
		PKG_HEIGHT.Text				= gcDs2.NameValue(ls_row,"PKG_HEIGHT");
		PKG_WIDTH.Text				= gcDs2.NameValue(ls_row,"PKG_WIDTH");
		PKG_CBM.Text					= gcDs2.NameValue(ls_row,"PKG_CBM");
		PKG_CNT.Text					= gcDs2.NameValue(ls_row,"PKG_CNT");
		TOTAL_PKG_CBM.Text		= gcDs2.NameValue(ls_row,"PKG_CNT") * PKG_CBM.Text;
		PKG_WGHT.Text					= gcDs2.NameValue(ls_row,"PUNIT_WGHT")* PKG_CBM.Text;
		FILENAME.value				= gcDs2.NameValue(ls_row,"REGFILENAME");
		 
		if(strim(FILENAME.value) !=""){ 
			down_img.style.display= "" ; 
			openfile1.style.display='none' ; 
		}	else{
			down_img.style.display= "none" ;  
			openfile1.style.display='' ; 
		}
	}

	/******************************************************************************
		Description :  Detail ������ ��Ī
	******************************************************************************/     
	function enable_packinfo(){
		if( MIX_OTHERS.checked == true ){
			PUNIT_CNT.Text	= 0;
			PUNIT_WGHT.Text = 0;
			PKG_LNGTH.Text	= 0;
			PKG_HEIGHT.Text = 0;
			PKG_WIDTH.Text	= 0;
			PKG_CBM.Text		= 0;        
			PKG_CNT.Text		= 0;

			PUNIT_CNT.disabled	= true;
			PUNIT_WGHT.disabled = true;
			PKG_LNGTH.disabled  = true;
			PKG_HEIGHT.disabled = true;
			PKG_WIDTH.disabled  = true;
			PKG_CBM.disabled		= true;
			PKG_CNT.disabled		= true;
		}	else{
			PUNIT_CNT.disabled  = false;
			PUNIT_WGHT.disabled = false;
			PKG_LNGTH.disabled  = false;
			PKG_HEIGHT.disabled = false;
			PKG_WIDTH.disabled  = false;
			PKG_CBM.disabled		= false;
			PKG_CNT.disabled		= false;
		}
	}

	/******************************************************************************
		Description : �������� ��� display----- > �Ϲ�
	******************************************************************************/
	function lf_car_input(){
		step2.style.display = "none" ; 
		step3.style.display = "" ; 

		gcDs4.DataId = g_dirPath+"/servlet/transfer.tr00101_s2?NOH=Y&gstr1=" +gs_ordno ; 
		gcDs4.Reset() ;

		carLdCargoLoad() ;
	}

	/******************************************************************************
		Description : ��ǰ���� �����ֱ�  ----- > �Ϲ�
	******************************************************************************/
	function lf_car_back(){
		step2.style.display = "" ; 
		step3.style.display = "none" ; 
	}

	/******************************************************************************
		Description : �������� Load
	******************************************************************************/ 
	function carLdCargoLoad(){
		//alert("gcDs4.CountRow:: "+gcDs4.CountRow );
		
		if( gcDs4.CountRow >0 ){
			var ls_car_seq_no = gcDs4.NameValue(gcDs4.RowPosition,"CAR_SEQ_NO")  ;
			gcDs3.DataId = g_dirPath+"/servlet/transfer.dsLdCarGoods?NOH=Y&gstr1="+gs_ordno+"&gstr2="+ ls_car_seq_no;  
			gcDs3.Reset() ; 
		}
	}

	/******************************************************************************
		Description : Cargo Mark ���
	******************************************************************************/
	function PRINT_CARGOMARK(){ 
		gcDsrpt1.DataId = g_dirPath+"/servlet/transfer.dsCargoMark?NOH=Y&gstr1="+gs_ordno ; 
		gcDsrpt1.Reset() ;  
	}

	/******************************************************************************
		Description : ���� ���� ���  
	******************************************************************************/ 
	function CalLoadCarCargo(row,colid){
		if(colid =="LD_PKG_CNT"   ){
			if(gcDs3.NameValue(row,"SAMEAS") !='T'){
				gcDs3.NameValue(row,"EXT_PKG_CNT")		= gcDs3.OrgNameValue(row,"EXT_PKG_CNT") * 1  + gcDs3.OrgNameValue(row,"LD_PKG_CNT")* 1  - gcDs3.NameValue(row,"LD_PKG_CNT");
				gcDs3.NameValue(row,"LD_ARTC_CNT")		= gcDs3.NameValue(row,"PUNIT_CNT") * gcDs3.NameValue(row,"LD_PKG_CNT");
				gcDs3.NameValue(row,"EXT_ARTC_CNT")		= gcDs3.OrgNameValue(row,"EXT_ARTC_CNT")*1  + gcDs3.OrgNameValue(row,"LD_ARTC_CNT")*1- gcDs3.NameValue(row,"LD_ARTC_CNT");
				gcDs3.NameValue(row,"LD_PUNIT_WGHT")	= gcDs3.NameValue(row,"PUNIT_WGHT") * gcDs3.NameValue(row,"LD_PKG_CNT");
				gcDs3.NameValue(row,"LD_PKG_CBM")			= gcDs3.NameValue(row,"PKG_CBM")  * gcDs3.NameValue(row,"LD_PKG_CNT");
				gcDs3.NameValue(row,"LD_PKG_WGHT")		= gcDs3.NameValue(row,"PUNIT_WGHT")  * gcDs3.NameValue(row,"LD_PKG_CNT");
			} else{ 
				gcDs3.NameValue(row,"EXT_PKG_CNT")		= gcDs3.OrgNameValue(row,"EXT_PKG_CNT")*1+gcDs3.OrgNameValue(row,"LD_PKG_CNT")*1 - gcDs3.NameValue(row,"LD_PKG_CNT");
			}
		}

		if(colid =="LD_ARTC_CNT"   ){
			if(gcDs3.NameValue(row,"SAMEAS") !='T'){
				gcDs3.NameValue(row,"EXT_ARTC_CNT") = gcDs3.OrgNameValue(row,"EXT_ARTC_CNT")*1 + gcDs3.OrgNameValue(row,"LD_ARTC_CNT") *1 - gcDs3.NameValue(row,"LD_ARTC_CNT");
			} else{ 
				gcDs3.NameValue(row,"EXT_ARTC_CNT") = gcDs3.OrgNameValue(row,"EXT_ARTC_CNT") *1+ gcDs3.OrgNameValue(row,"LD_ARTC_CNT") *1 - gcDs3.NameValue(row,"LD_ARTC_CNT");
			}
		}
	}

	/******************************************************************************
		Description : ���� ���� ���� ����
	******************************************************************************/ 
	function CheckTrueSameAs(row,colid){
		if(colid =="CHK" ){
			var ls_check	= gcDs3.NameValue(row,colid);
			var ls_no			= gcDs3.NameValue(row,"ORDER_NO");
			var ls_pkg		= gcDs3.NameValue(row,"ORDER_SEQ");
			var ls_pkg1		= gcDs3.NameValue(row,"SAMEAS");

			if (strim(ls_check)=="" || strim(ls_check)=="F" )	{
				gcDs3.NameValue(row,colid) = "T";
				CheckTrueDataMove(row,colid);

				for(i=1; i<=gcDs3.CountRow; i++) {
					if(ls_no == gcDs3.namevalue(i,"ORDER_NO") && ls_pkg1 == gcDs3.NameValue(i,"SAMEAS") && gcDs3.NameValue(i,"SAMEAS") != ""){ 
						gcDs3.NameValue(i,colid) = "T"; 
						CheckTrueDataMove(i,'CHK');
					}
				}
			} else {
				gcDs3.NameValue(row,colid) = "F";
				CheckTrueDataMove(row,colid);

				for(i=1; i<=gcDs3.CountRow; i++) {
					if(ls_no == gcDs3.namevalue(i,"ORDER_NO") && ls_pkg1 == gcDs3.NameValue(i,"SAMEAS") && gcDs3.NameValue(i,"SAMEAS") != ""){ 
						gcDs3.NameValue(i,colid) = "F"; 
						CheckTrueDataMove(i,'CHK');
					}
				}
			}
		}
	}

	/******************************************************************************
		Description : ��ǰ ���ý� ���
	******************************************************************************/ 
	function CheckTrueDataMove(row,colid){
		if(gcDs3.NameValue(row,colid) =="T"){ //üũ�Ǿ����� 
			gcDs3.NameValue(row,"EXT_PKG_CNT")	= 0;
			gcDs3.NameValue(row,"LD_PKG_CNT")		= gcDs3.OrgNameValue(row,"EXT_PKG_CNT") * 1 + gcDs3.OrgNameValue(row,"LD_PKG_CNT") *1; 
			CalLoadCarCargo(row,'LD_PKG_CNT');
			gcDs3.NameValue(row,"EXT_ARTC_CNT")	= 0;
			gcDs3.NameValue(row,"LD_ARTC_CNT")	= gcDs3.OrgNameValue(row,"EXT_ARTC_CNT") * 1 + gcDs3.OrgNameValue(row,"LD_ARTC_CNT") *1;
		}	else{ //üũ ���� �Ǿ�����
			gcDs3.NameValue(row,"EXT_PKG_CNT")	= gcDs3.OrgNameValue(row,"EXT_PKG_CNT") * 1 + gcDs3.OrgNameValue(row,"LD_PKG_CNT") *1; 
			gcDs3.NameValue(row,"LD_PKG_CNT")		= 0;
			CalLoadCarCargo(row,'LD_PKG_CNT');
			gcDs3.NameValue(row,"EXT_ARTC_CNT") = gcDs3.OrgNameValue(row,"EXT_ARTC_CNT") * 1 + gcDs3.OrgNameValue(row,"LD_ARTC_CNT") *1;
			gcDs3.NameValue(row,"LD_ARTC_CNT")	= 0;
		}  
	}

	/******************************************************************************
		Description : ���õ� ���� �� ����
	******************************************************************************/ 
	function gcGR3ColorChange(row,eventid){
		if(eventid == "acolor") {
			if(gcDs3.NameValue(row,"CHK") == "T" ) return '#FAFCA7' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor1") {
			if(gcDs3.NameValue(row,"CHK") == "T" ) return '#FFCCCC' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor2") { 
			if(gcDs3.NameValue(row,"EXT_PKG_CNT") != 0 ) return "#FF0033" ;
			else return "#330000" ;
		}

		if(eventid == "acolor3") { 
			if(gcDs3.NameValue(row,"EXT_ARTC_CNT") != 0 )	return "#FF0033" ;
			else return "#330000" ;
		}
	}

	/******************************************************************************
		Description :  ���� ������ Text ---> DataSet
	******************************************************************************/    
  function NewCar_Insert(){
		ls_Carinsert			= true ; //�űԼ���
		CAR_TYPE.index		= 0;
		CAR_CNT.value			= 1;
		LOAD_DATE.Text		= ETD_DT1.Text;
		CAR_EDT_DATE.Text		= ETD_DT.Text;
		CAR_EDT_DATE.Enable = false;
		CTN_STDRD.value		= "";
		CAR_REMARK.value	= "";
		LCT_URL.value			= "";
	}

  /******************************************************************************
		Description :  ���� ������ �߰���
	******************************************************************************/    
	function CarDetail_Insert(){
		//alert("CarDetail_Insert:;"+CarDetail_Insert);
		var ls_dlvl	="0001";
		var ls_dlvl	   = DLVL_TYPE.ValueOfIndex("MINORCD", DLVL_TYPE.index);
		var ls_project = LINE_PART.ValueOfIndex("MINORCD", LINE_PART.index);

		gcDs4.Addrow();
		var row = gcDs4.rowposition

		if(ls_dlvl == "0001" ) {
			if(ls_project == '0001') {		//����
				gcDs4.namevalue(row,"LD_CARGO") = "0001";
				gcDs4.namevalue(row,"OFF_CARGO") = "0003";
			}	else if(ls_project == '0002') {		//�ݰ���
				gcDs4.namevalue(row,"LD_CARGO") = "0007";
				gcDs4.namevalue(row,"OFF_CARGO") = "0005";
			} else {  //ö��
				gcDs4.namevalue(row,"LD_CARGO") = "0001";
				gcDs4.namevalue(row,"OFF_CARGO") = "0003";
			} 

		} else gcDs4.namevalue(row,"LD_CARGO") = "";

		gcDs4.namevalue(row,'CAR_CNT')	= '1';
		gcDs4.namevalue(row,'IN_OUT')	= 'O';

		if (row>1) gcDs4.namevalue(row,"CARTYPENO")  = gcDs4.namevalue(1,"CARTYPENO");
	}

  /******************************************************************************
		Description :  ���� ������ Text ---> DataSet
	******************************************************************************/    
  function CarDetail_Match(){
		if (ls_Carinsert == true ){ 
			saveing = true ;  
			gcDs4.AddRow () ; 
		}

		var row =  gcDs4.Rowposition ; 
		gcDs4.NameValue(row,"CARTYPENO")	= CAR_TYPE.BindColVal;
		gcDs4.NameValue(row,"CAR_CNT")		= CAR_CNT.value;
		gcDs4.NameValue(row,"LD_DATE")		= gcDs1.NameValue(1,"ETD_DT1");
		gcDs4.NameValue(row,"REMARK")			= CAR_REMARK.value;
		gcDs4.NameValue(row,"CTN_STDRD")	= CTN_STDRD.value;
		gcDs4.NameValue(row,"EDT_DATE")		= gcDs1.NameValue(1,"ETD_DT");
		gcDs4.NameValue(row,"LCT_URL")		= LCT_URL.value;
		gcDs4.NameValue(row,"CREATE_USR") = "";
		gcDs4.NameValue(row,"UPDATE_USR") = "";
		gcDs4.NameValue(row,"LINE_PART")	= gcDs1.NameValue(1,"LINE_PART");
		gcDs4.NameValue(row,"IN_OUT")			= gs_inout;

		saveing = false ;
	}

	/******************************************************************************
		Description :  ���� ������ DATASET ---> TEXT
	******************************************************************************/    
  function CarDataSet_ToText() {
		var row =  gcDs4.Rowposition ; 

		CAR_TYPE.BindColVal = gcDs4.NameValue(row,"CARTYPENO");
		CAR_CNT.value				= gcDs4.NameValue(row,"CAR_CNT");
		LOAD_DATE.Text			= gcDs4.NameValue(row,"LD_DATE");
		CAR_REMARK.value		= gcDs4.NameValue(row,"REMARK");
		CTN_STDRD.value			= gcDs4.NameValue(row,"CTN_STDRD");
		CAR_EDT_DATE.Text		= gcDs4.NameValue(row,"EDT_DATE");
		LCT_URL.value				= gcDs4.NameValue(row,"LCT_URL");
	}

	/******************************************************************************
		Description :  �������� Save
	******************************************************************************/     
  function CarDetail_Save2(){

		if (!gcDs4.isUpdated) return;

		var row = gcDs4.rowposition;

		if (gcDs4.namevalue(row,"CARTYPENO")==""){
			alert("������ �����Ͻʽÿ�");
			return;
		}

		if (gcDs4.namevalue(row,"CTN_STDRD")==""){
			alert("��ǥǰ���� �Է��Ͻʽÿ�");
			return;
		}

		if (gcDs4.namevalue(row,"LD_CARGO")==""){
			alert("�������� �Է��Ͻʽÿ�");
			return;
		}

		if (gcDs4.namevalue(row,"OFF_CARGO")==""){
			alert("��ǥǰ���� �Է��Ͻʽÿ�");
			return;
		}

		if (!confirm("�Է��Ͻ� ���������� �����Ͻðڽ��ϱ� ?  ")) return;

		if (gs_ordno==null || gs_ordno=="") gs_ordno = "9999";

		gcTr03.KeyValue = "trOrderCar(I:USER=gcDs4)";
		gcTr03.Action = g_dirPath+"/servlet/transfer.trOrderCar";
		gcTr03.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ
		gcTr03.post(); 

		gcDs4.DataId = g_dirPath+"/servlet/transfer.tr00101_s2?NOH=Y&gstr1="+gs_ordno ; 
		gcDs4.Reset();
	}

	/******************************************************************************
		Description :  �������� Save
	******************************************************************************/     
  function CarDetail_Save(){
		if(!CarDataCheck()){return false ; }

		CarDetail_Match();

		gcTr03.KeyValue = "trOrderCar(I:USER=gcDs4)";
		gcTr03.Action = g_dirPath+"/servlet/transfer.trOrderCar";
		gcTr03.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ
		gcTr03.post(); 

		gcDs4.DataId = g_dirPath+"/servlet/transfer.tr00101_s2?NOH=Y&gstr1=" + gs_ordno ; 
		gcDs4.Reset() ;
	}

	/******************************************************************************
		Description :  �������� Delete
	******************************************************************************/     
  function CarDetail_Delete(){
		if (gcDs4.countrow<1) return;

		if (gcDs4.sysStatus(gcDs4.rowposition)=="1") {
			gcDs4.undo(gcDs4.rowposition);
			return;
		}

		if (confirm("�����Ͻ� ������ ����� ��ǰ ������ �Բ� �����˴ϴ�.  \n\n�����Ͻ� ������ �����Ͻðڽ��ϱ� ?  ")) {

			gcDs4.deleterow(gcDs4.rowposition);

			gcTr03.KeyValue = "trOrderCar(I:USER=gcDs4)";
			gcTr03.Action = g_dirPath+"/servlet/transfer.trOrderCar";
			gcTr03.Parameters = "gstr1=all" ; //�ֹ���ȣ
			gcTr03.post(); 

			gcDs4.DataId = g_dirPath+"/servlet/transfer.tr00101_s2?NOH=Y&gstr1="+gs_ordno;
			gcDs4.Reset();
		}
	}


	/******************************************************************************
		Description :  ���� ��� ����
	******************************************************************************/      
  function CarGoods_SAVE(){
		var ls_car_seq_no = gcDs4.NameValue(gcDs4.RowPosition,"CAR_SEQ_NO")  ; 

		gcTr04.KeyValue = "trOrderRegCarGoods(I:USER=gcDs3)";
		gcTr04.Action = g_dirPath+"/servlet/transfer.trOrderRegCarGoods";
		gcTr04.Parameters = "gstr1="+gs_ordno+",gstr2="+ ls_car_seq_no ; //�ֹ���ȣ
		gcTr04.post(); 
		 
		gcDs3.DataId =  g_dirPath+"/servlet/transfer.dsLdCarGoods?NOH=Y&gstr1="+gs_ordno+"&gstr2="+ ls_car_seq_no;  
		gcDs3.Reset() ; 
	}

	/******************************************************************************
		Description :  �������� ������ üũ
	******************************************************************************/     
  function  CarDataCheck(){
		if(CAR_TYPE.index == 0 ) {
			alert("������ �����Ͻʽÿ�");
			return false;
		}

		if(CAR_CNT.value == 0 || strim(CAR_CNT.value)==""){
			alert("���� ����� �����Ͻʽÿ�");
			return false ; 
		}

		if(strim(CTN_STDRD.value) == "" ) {
			alert("��ǥǰ���� �Է��Ͻʽÿ� ");
			return false ; 
		} 
		
		return true ; 
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_Divide(str, delim){
		var strArr = str.split(delim);
		var rtn = "";
		var a = strArr.length;

		if(a>0) rtn=strArr[a-1];

		strArr = null;
		return rtn;
	}

	/******************************************************************************
		Description : DownLoad --- >  ���� ����� �ٿ�ε�
	******************************************************************************/
	function DownLoadFile(ls_type){
		if(ls_type == "1") {
			var w = window.top.screen.width;
			var h = window.top.screen.height;
			var Lf=0, Tp=15;
			if(w>=600){Lf=(w-750);}
			if(h>=500){Tp=(h-570);}
			var tmaifname = ln_Divide(FILENAME.value, "\\");
			var strURL = g_dirPath+"/servlet/transfer.dsDetailDownLoad?gstr1="+gs_ordno+"&gstr2=" + gcDs2.NameValue(gcDs2.Rowposition,"ORDER_SEQ") + "&gstr3=" + tmaifname;
				
			var pan = window.open(strURL,"","toolbar=no,menubar=no,scrollbars=no,resizable=yes,width=0,height=0,left=999999,top=999999");
		}
	}

	/******************************************************************************
		Description : DownLoad --- >  Excel Popup
	******************************************************************************/
	function ExcelLoad(){ 
		window.open('/transfer/html/uploadpage.html','','top=200px,left=300px,resizable=no,width=450,height=58,scrollbars=no');
	}

	/******************************************************************************
		Description : DownLoad --- > Excel DataLoad
	******************************************************************************/
	function ln_Query(e){
		gcds_data.DataID = g_dirPath+"/servlet/transfer.excel_load2?v_str1=" + e;
		gcds_data.Reset();
	}

	/******************************************************************************
		Description :  Excel DataSet ----> Detail DataSet
	******************************************************************************/
	function ExceltoDataSet(){
		var rowP = null ; 
		var ls_pkg_cnt = 0 ; 
		var ls_same_no = null ;
		var ls_same_row = null ;
		var ls_unit = null ;  

		gcDs2.UndoAll();

		for(row=1;row<=gcds_data.CountRow;row++){
			gcDs2.AddRow() ; 
			rowP = gcDs2.Rowposition ; 

			gcDs2.NameValue(rowP,"LDCARGONM")		= gcds_data.NameValue( row,"parm4");//������
			gcDs2.NameValue(rowP,"OFFCARGONM")	= gcds_data.NameValue( row,"parm5"); //������
			gcDs2.NameValue(rowP,"ENG_ARTCNM")	= gcds_data.NameValue( row,"parm6"); //������
			gcDs2.NameValue(rowP,"ARTC_CD")			= "9999" ; //ǰ��
			gcDs2.NameValue(rowP,"ARTC_NM")			= gcds_data.NameValue( row,"parm8"); //ǰ��
			gcDs2.NameValue(rowP,"STN_SZNM")		=	gcds_data.NameValue( row,"parm9"); //�԰�
			ls_unit= gcds_data.NameValue( row,"parm10"); //����
			PutUnit(ls_unit,rowP);
			gcDs2.NameValue(rowP,"ARTC_CNT")		= gcds_data.NameValue( row,"parm11"); //�԰�
			gcDs2.NameValue(rowP,"UNIT_PRICE")	= gcds_data.NameValue( row,"parm12"); //�ܰ�
			gcDs2.NameValue(rowP,"PRICE")				= gcds_data.NameValue( row,"parm13"); //�ݾ�
			gcDs2.NameValue(rowP,"PUNIT_CNT")		= gcds_data.NameValue( row,"parm14"); //�������庰 ����
			gcDs2.NameValue(rowP,"PUNIT_WGHT")	= gcds_data.NameValue( row,"parm15"); //�������庰 �߷�
			gcDs2.NameValue(rowP,"PKG_LNGTH")		= gcds_data.NameValue( row,"parm16"); //�������庰 ���� 
			gcDs2.NameValue(rowP,"PKG_WIDTH")		=	gcds_data.NameValue( row,"parm17"); //�������庰 ��
			gcDs2.NameValue(rowP,"PKG_HEIGHT")	= gcds_data.NameValue( row,"parm18"); //�������庰 ����
			gcDs2.NameValue(rowP,"PKG_CBM")			= gcds_data.NameValue( row,"parm19"); //�������庰 cbm
			gcDs2.NameValue(rowP,"PKG_CNT")			= gcds_data.NameValue( row,"parm20"); //�������庰 ����
			gcDs2.NameValue(rowP,"LDCARGO")			= gcDs4.namevalue(1,"LD_CARGO");
			gcDs2.NameValue(rowP,"OFFCARGO")		= gcDs4.namevalue(1,"OFF_CARGO");

			ls_pkg_cnt = gcDs2.NameValue(rowP,"PUNIT_CNT");
			if(rowP == 1){ 
				gcDs2.NameValue(rowP,"ORDER_SEQ") = 1;
				if( ls_pkg_cnt  == "" ||  ls_pkg_cnt == 0 || ls_pkg_cnt  == null){
					alert("ù��° �����ʹ� ���� ���� ������ �־�� �մϴ�. Ȯ�� ") ; 
					gcDs2.DeleteRow(rowP);
					return;
				}
			}	else {
				gcDs2.NameValue(rowP,"ORDER_SEQ")= (gcDs2.NameValue(rowP-1,"ORDER_SEQ") * 1 ) + 1; 
			}

			if(  ls_pkg_cnt  != null && ls_pkg_cnt != 0 && ls_pkg_cnt != ""){
				ls_same_no = gcDs2.NameValue(rowP,"ORDER_SEQ");
				ls_same_row = rowP;
			}	else {
				gcDs2.NameValue(rowP,"MIX_OTHERS") = "T";
				gcDs2.NameValue(ls_same_row,"MIX_OTHERS") = "T";
				gcDs2.NameValue(rowP,"SAMEAS") = ls_same_no;
				gcDs2.NameValue(ls_same_row,"SAMEAS") = ls_same_no;
			}
		}

		gcTr02.KeyValue = "trOrderRegDtl(I:USER=gcDs2)";
		gcTr02.Action = g_dirPath+"/servlet/transfer.trOrderRegDtl";  
		gcTr02.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ 
//		gcTr02.post(); 
//		gcDs2.Reset();
	}

	/******************************************************************************
		Description :  ���� Open �̹��� -----> ���Ͽ���
	******************************************************************************/
	function OpenFile(){ 
		OpenFile.Open();  
	}

	/******************************************************************************
		Description :  Excel ����  --- > �ڵ� 
	******************************************************************************/
	function PutUnit(ls_unit,rowP){
		gcds_dump.DataId = g_dirPath+"/servlet/transfer.dsGetUnit?NOH=Y&gstr1="+ ls_unit+"&gstr2="+rowP ; 
		gcds_dump.Reset() ; 
	}

	/******************************************************************************
		Description :  Excel ����  --- > �ڵ� 
	******************************************************************************/
	function PutUnitCode(){
		if(gcds_dump.CountRow > 0 ){
			var row = gcds_dump.NameValue(1,"ROWP") * 1 ; 
			gcDs2.NameValue(row,"ARTC_UNIT") =  gcds_dump.NameValue(1,"MINORCD") ;  
		}
	}

	/******************************************************************************
		Description : ������
	******************************************************************************/
	function  Call_PLCST() {
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	

		if(PopWinValue != null ){ 
			PL_CSTM.value			= PopWinValue[0];
			PL_CSTMNM.value		= PopWinValue[1];
			PL_CSTTEL.value		= PopWinValue[4]; 
			PL_CSTADDR.value  = PopWinValue[7];
			PL_CSTADDR2.value = PopWinValue[8];
		}
	}

	/******************************************************************************
		Description :	������
	******************************************************************************/
	function Call_SHIPPER(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	

		if(PopWinValue != null ){
			PL_SHIPPER.value  = PopWinValue[0];
			PL_SHPPRNM.value	= PopWinValue[1];
			PL_SHIPTEL.value	= PopWinValue[4];
			PL_SHIPADDR.value = PopWinValue[7];
			PL_SHPADDR2.value = PopWinValue[8];
		}
	}

	/******************************************************************************
		Description : ��Ź��
	******************************************************************************/
	function Call_CS(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	

		if(PopWinValue != null ){
			PL_CSN.value			= PopWinValue[0];
			PL_CSNNM.value		= PopWinValue[1];
			PL_CSNTEL.value		= PopWinValue[4];
			PL_CSNADDR.value	= PopWinValue[7];
			PL_CSNADDR2.value	= PopWinValue[8];
		}
	}

	/******************************************************************************
		Description : ����ó
	******************************************************************************/
	function Call_BRKR(){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	

		if(PopWinValue != null ){
			PL_BRKR.value			= PopWinValue[0];
			PL_BRKRNM.value		= PopWinValue[1];
			PL_BRKTEL.value		= PopWinValue[4];
			PL_BRKADDR.value  = PopWinValue[7];
			PL_BRKADDR2.value = PopWinValue[8];
		} 
	}

	/******************************************************************************
		Description : ��������
	******************************************************************************/
	function CallCarType(){
		strURL = "TR00102_E5.html";
		PopupOpenDialog(500,420) ;	
		
		if(PopWinValue != null ) CAR_TYPE.index = CAR_TYPE.ValueOfIndex("CAR_TYPE", PopWinValue[0]);
	}

	/******************************************************************************
		Description : ������Ʈ ����
	******************************************************************************/
	function locationSetting() {
		var ls_project = LINE_PART.ValueOfIndex("MINORCD", LINE_PART.index);

		if(ls_project == '0001') gcDs4.namevalue(1,"OFF_CARGO") = "0003";	//����
		else if(ls_project == '0002') gcDs4.namevalue(1,"OFF_CARGO") = "0004"; // �ݰ���
		else gcDs4.namevalue(1,"OFF_CARGO") = "0003"; //ö��
	}

	/******************************************************************************
		Description : ������Ʈ ����
	******************************************************************************/
	function locationSetting2(){
		var ls_dlvl = DLVL_TYPE.ValueOfIndex("MINORCD", DLVL_TYPE.index);
		var ls_project = LINE_PART.ValueOfIndex("MINORCD", LINE_PART.index);
		var ls_cargo_type = CARGO_TYPE.bindcolval;

		if(ls_dlvl == "0001" ) {
			tr_att_file.style.display = "none";
			tr_att_info.style.display = "none";

			if (ls_cargo_type=="0003"||ls_cargo_type=="0004"){
				tr_att_file.style.display = "";
				ft_fname.innerText = "�����÷��";
			} 

			if(ls_project == '0001') {		//����
				for (var k=1; k<=gcDs4.countrow; k++) {
					gcDs4.namevalue(k,"LD_CARGO") = "0001";
					gcDs4.namevalue(k,"OFF_CARGO") = "0003";
				}
			}	else if(ls_project == '0002') {		//�ݰ���
				for (var k=1; k<=gcDs4.countrow; k++) {
					gcDs4.namevalue(k,"LD_CARGO") = "0145";
					gcDs4.namevalue(k,"OFF_CARGO") = "0004";
				}
			} else {  //ö��
				for (var k=1; k<=gcDs4.countrow; k++) {
					gcDs4.namevalue(k,"LD_CARGO") = "0001";
					gcDs4.namevalue(k,"OFF_CARGO") = "0003";
				}
			} 

		} else {
			for (var k=1; k<=gcDs4.countrow; k++) gcDs4.namevalue(k,"LD_CARGO") = "";

			if (ls_cargo_type=="0003"||ls_cargo_type=="0004") ft_fname.innerText = "�����&÷�ξ൵";
			else ft_fname.innerText = "÷�ξ൵";

			tr_att_file.style.display = "";
			tr_att_info.style.display = "";
		}
	}

	/******************************************************************************
		Description :   
	******************************************************************************/
	function EdtDateCheck(){
		var etd_dt = ETD_DT.Text; 
		var cal_dt = "";

		gcDs_etc14.DataId = g_dirPath+"/servlet/transfer.dsCalendar?NOH=Y&gstr1=" + LINE_PART.BindColVal + "&gstr4=" + etd_dt;
		//prompt('',gcDs_etc14.DataId );
		gcDs_etc14.Reset();

		if(gcDs_etc14.CountRow < 1 ){
			alert("���밡���� �������ڰ� �ƴմϴ�.");
			ETD_DT.Text = "" ;
			ETD_DT1.text = "" ;
		} else if (gcDs_etc14.CountRow > 0 ){
			if (gcDs_etc14.CountRow == 2 ) var row = 2;
			else if (gcDs_etc14.CountRow ==1 ) var row = 1;

			cal_dt = gcDs_etc14.NameValue(row,"CAL_DT");
/*
			if (cal_dt<gn_Replace(gcurdate,"-")){
				alert(cal_dt);alert(gcurdate);
				alert("���밡���� �������ڰ� �ƴմϴ�!");
				ETD_DT.Text = "" ;
				ETD_DT1.text = "" ;
			} else if(gn_Replace(gcurdate,"-") == cal_dt ){
				if (gcDs_etc14.namevalue(row,"CHOUR")>11)	{
					alert("���밡���� �������ڰ� �ƴմϴ�.") ; 
					ETD_DT.Text = "" ;
					ETD_DT1.text = "" ;
					return;
				}
			} else {
				if(DLVL_TYPE.index != 2) ETD_DT1.Text = gcDs_etc14.NameValue(row,"APP_DT2");
				if(DLVL_TYPE.index == 2) ETD_DT1.Text = gcDs_etc14.NameValue(row,"APP_DT3");
			} */
		}		
		/*
		var etd_dt = ETD_DT.Text; 
		var app_dt = "";
		var holy_div = "";

		gcDs_etc14.DataId = "/servlet/transfer.dsCalendar?NOH=Y&gstr1="+LINE_PART.BindColVal +"&gstr2="+ __ymd; 
		gcDs_etc14.Reset() ;   

		if(gcDs_etc14.CountRow > 0 ){
			app_dt = gcDs_etc14.NameValue(1,"APP_DT1") ; 

			if(etd_dt < app_dt ){
				alert("���밡���� �������ڰ� �ƴմϴ�.") ; 
				ETD_DT.Text = "" ;
				return ; 
			} 
		}

		gcDs_etc14.DataId = "/servlet/transfer.dsCalendar?NOH=Y&gstr1="+LINE_PART.BindColVal +"&gstr4="+ etd_dt; 
		gcDs_etc14.Reset() ;

		if(gcDs_etc14.CountRow > 0 ){
			holy_div = gcDs_etc14.NameValue(1,"HOLY_DIV") ; 
			if(holy_div == "0"){ 
				alert("���밡���� �������ڰ� �ƴմϴ�. -  ���� ") ; 
				ETD_DT.Text = "" ;
				return ; 
			}	else{
				if(DLVL_TYPE.index !=2){
					ETD_DT1.Text =  gcDs_etc14.NameValue(1,"APP_DT2") ; 
				}
				if(DLVL_TYPE.index == 2){
					ETD_DT1.Text = gcDs_etc14.NameValue(1,"APP_DT3") ;  
				}
			}
		}	else {
			alert("���밡���� �������ڰ� �ƴմϴ�.") ; 
			ETD_DT.Text = "" ;
		}
		*/
	}

	/******************************************************************************
		Description : �൵���� �ٿ�ε�
	******************************************************************************/
	function ln_FileDown(){
		
		//alert("order.js");
		var ordid = gcDs1.namevalue(1,"ORDER_NO");
		if (strim(ordid)=="") {
			alert("�ٿ�ε� �Ͻ� �൵������ �����ϴ�.");
			return;
		}

		var sMap = "tr00102_e6.jsp";
		var sSet = "menu=no,resizable=yes,width=800,height=600,scrollbars=no";
		window.open(sMap,ordid,sSet)
	}

	/******************************************************************************
		Description : �ڵ�����
	******************************************************************************/
	function lf_confirm(){
		gcds_chk.DataId = g_dirPath+"/servlet/transfer.dsLdCarGoods_2?gstr1="+gs_ordno;
		gcds_chk.Reset() ; 

		if (gcds_chk.namevalue(1,"CNT")>0) {
			alert("�� �����Ͻ� �ڷᰡ �����մϴ�. \n\n�ڵ� �����Ͻ� �� �����ϴ�.  ");
			return;
		}

		if (gcDs2.countrow>1)	{
			gcds_chk.DataId = g_dirPath+"/servlet/transfer.trLdCarGoods_2?gstr1="+gs_ordno+"&gstr2="+gcDs4.countrow;
			gcds_chk.Reset();
		}	else if (gcDs2.countrow==1) {
			if (gcDs4.countrow > gcDs2.namevalue(1,"ARTC_CNT")) {
				alert("�Է��Ͻ� �������� ��ǰ ������ �ʰ��� �� �����ϴ�.");
				return;
			}

			gcds_chk.DataId = g_dirPath+"/servlet/transfer.trLdCarGoods_3?gstr1="+gs_ordno+"&gstr2="+gcDs2.namevalue(1,"ORDER_SEQ")+"&gstr3="+gcDs4.countrow;;
			gcds_chk.Reset();
		}

		if (gcds_chk.namevalue(1,"RTN")=="S") alert("���������� �ڵ����� �۾��� �Ϸ�Ǿ����ϴ�.");
	}

	/******************************************************************************
		Description : Ź��/�Ǽ������ ���
	******************************************************************************/
	function ln_DispGrid(e){
		var ls_html = "";

		if (e=="0003" || e=="0004") {
			ls_html += "	<F> Name='No.'      ID=CurRow     HeadAlign=Center HeadBgColor=#eeeeee Width=30  align=center  edit=none Value={CurRow} </F>   ";
			ls_html += "	<F> Name='No.'			ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30	 align=center  edit=none show=false</F>   ";
      ls_html += "	<F> Name='�����2222;(�Ǽ�����)'	ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=left</F>";
      ls_html += "	<C> Name='��Ϲ�ȣ��'					ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left, sumText='�հ�'</C>";
      ls_html += "	<C> Name='�����ȣ��'					ID=VIN_CODE		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left</C>";
      ls_html += "	<G> Name ='����' HeadBgColor=#eeeeee";
      ls_html += "		<C> Name='����(CM)��'	ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right, dec=0</C> ";
      ls_html += "		<C> Name='��(CM)��'		ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right, dec=0</C> ";
      ls_html += "		<C> Name='����(CM)��'	ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right, dec=0</C> ";
      ls_html += "		<C> Name='���߷�(KG)'	ID=PUNIT_WGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=87  align=right,	dec=1, sumText=@sum</C>   ";
      ls_html += "	</G>";
      ls_html += "	<C> Name='�ܰ�(��)'	ID=UNIT_PRICE HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>";
      ls_html += "	<C> Name='�ݾ�(��)'	ID=PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> ";
      ls_html += "	<C> Name='ȭ��'			ID=CUR_CODE		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center</C>";
      ls_html += "	<C> Name='�ܰ�(��ȭ)'	ID=FR_UNTRPRCE	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>";
      ls_html += "	<C> Name='�ݾ�(��ȭ)'	ID=FR_PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> ";
		} else {
			ls_html += "	<F> Name='No.'      ID=CurRow     HeadAlign=Center HeadBgColor=#eeeeee Width=30  align=center  edit=none Value={CurRow}</F>   ";
			ls_html += "	<F> Name='No.'			ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30	 align=center, edit=none  show=false</F>   ";
      ls_html += "	<F> Name='������'		ID=LDCARGO  	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_LDCARGO,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center, editstyle=LookUp Data='gcDs_etc8:MINORCD:MINORNM'</F>";
      ls_html += "	<F> Name='������'		ID=OFFCARGO		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_OFFCARGO,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center, editstyle=LookUp Data='gcDs_etc9:MINORCD:MINORNM'</F>";
      ls_html += "	<F> Name='������'		ID=ENG_ARTCNM	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_ENG_ARTCNM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=left, show=false</F>";
      ls_html += "	<F> Name='HS code'	ID=HSCODE  		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center, editStyle=Popup, show=false</F>";
      ls_html += "	<F> Name='HS Name'	ID=HSCODENM 	HeadAlign=Center HeadBgColor=#eeeeee Width=137  align=left, show=false </F> ";
      ls_html += "	<F> Name='ǰ��'			ID=ARTC_NM  	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_ARTC_NM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=left, sumText='�հ�'</F>";
      ls_html += "	<C> Name='�԰�'			ID=STN_SZNM		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_STN_SZNM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left</C>";
      ls_html += "	<C> Name='����'			ID=ARTC_UNIT	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_ARTC_UNIT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left,	 editstyle=LookUp Data='gcDs_etc6:MINORCD:MINORNM'</C>";
      ls_html += "	<C> Name='����'			ID=ARTC_CNT		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_ARTC_CNT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right, sumText=@sum</C> ";
      ls_html += "	<C> Name='�ܰ�(��)'	ID=UNIT_PRICE BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_UNIT_PRICE,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, dec=0</C>";
      ls_html += "	<C> Name='�ݾ�(��)'	ID=PRICE			BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PRICE,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> ";
			ls_html += "	<C> Name='ȭ��'				ID=CUR_CODE			HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center</C>";
			ls_html += "	<C> Name='�ܰ�(��ȭ)'	ID=FR_UNTPRCE		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C>";
      ls_html += "	<C> Name='�ݾ�(��ȭ)'	ID=FR_PRICE			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right, sumText=@sum</C> ";
			ls_html += "	<G> Name ='��������' HeadBgColor=#eeeeee";
      ls_html += "		<C> Name='����'			ID=PUNIT_CNT  	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PUNIT_CNT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0, sumText=@sum</C>   ";
      ls_html += "		<C> Name='�߷�(KG)'	ID=PUNIT_WGHT  	BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PUNIT_WGHT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right, dec=0, sumText=@sum</C>";
      ls_html += "		<C> Name='����(CM)'	ID=PKG_LNGTH		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PKG_LNGTH,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> ";
      ls_html += "		<C> Name='��(CM)'		ID=PKG_WIDTH		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PKG_WIDTH,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> ";
      ls_html += "		<C> Name='����(CM)'	ID=PKG_HEIGHT		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PKG_HEIGHT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=right, dec=0</C> ";
      ls_html += "	</G>";
      ls_html += "	<C> Name='�������庰;����(CBM)' ID=PKG_CBM			BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PKG_CBM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#FFF589 Width=120	align=right, dec=3, sumText=@sum, sumBgColor=#FFF589</C> ";
      ls_html += "	<C> Name='�������庰;�Ѽ���'		ID=PKG_CNT	 		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_PKG_CNT,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#FFF589 Width=100  align=right,dec=2, sumText=@sum, sumBgColor=#FFF589</C>   ";
      ls_html += "	<C> Name='�ѿ���(CBM)'		ID=PKG_CBM_T 			HeadAlign=Center HeadBgColor=#FFF589 Width=100  align=right,	dec=3, sumText=@sum, sumBgColor=#FFF589</C>   ";
      ls_html += "	<C> Name='���߷�(KG)'			ID=PUNIT_WGHT_T		HeadAlign=Center HeadBgColor=#FFF589 Width=100  align=right,	dec=1, sumText=@sum, sumBgColor=#FFF589</C>   ";
      ls_html += "	<C> Name='�������߰�����' ID=LDCARGONM			BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_LDCARGONM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C>   ";
      ls_html += "	<C> Name='�������߰�����' ID=OFFCARGONM			BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_OFFCARGONM,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=128  align=left </C>   ";
      ls_html += "	<C> Name='��������'				ID=MIX_OTHERS  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, show=false </C>   ";
      ls_html += "	<C> Name='��������;No'		ID=SAMEAS  				BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_SAMEAS,'N','#FDF98F','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center</C> 		";
		}

		gcGR1.format = ls_html;

	}

	/******************************************************************************
		Description : �ֹ���� ȭ�鿡�� ���¸� �����Ҷ�
	******************************************************************************/
	function ln_StsSave(){
		if (confirm("��ϵ� �ֹ������� ����ó�� �Ͻðڽ��ϱ�? ")){
			gcds_chk.DataID = g_dirPath+"/servlet/transfer.dsOrderStsReg?v_str1=" + gs_ordno; 
			//prompt("gcds_chk",gcds_chk.DataID);
			gcds_chk.Reset();

			//alert("rst::"+gcds_chk.namevalue(1,"rst"));
			if (gcds_chk.namevalue(1,"rst")=="Y") alert("���������� ����ó�� �Ǿ����ϴ�.");
			else alert("����ó�� �� ������ �߻��Ͽ����ϴ�.");
		}
	}

	/******************************************************************************
		Description : �ֹ� ���
	******************************************************************************/
	function ln_Cancel(){
		if (!confirm("�ۼ����� �ֹ������� ����Ͻðڽ��ϱ� ?"))	return;

		gcds_chk.DataID = g_dirPath+"/servlet/transfer.trOrderCancel?v_str1=" + gs_ordno; 
		gcds_chk.Reset();

		//alert("RTN::"+gcds_chk.namevalue(1,"RTN"));

		if (gcds_chk.namevalue(1,"RTN")=="Y")	{
			if (confirm("�ֹ������� ���������� ��ҵǾ����ϴ�. �ֹ��� ��� �Է��Ͻðڽ��ϱ� ?")) window.location.href="../../transfer/html/TR00102.html";
			else window.location.href="../../transfer/html/TR00101.html";
		}
	}

	/******************************************************************************
		Description : �ֹ� �ӽ�����
	******************************************************************************/
	function ln_RegData(){
		var dsp1 = step1.style.display;
		var dsp2 = step2.style.display;
		var dsp3 = step3.style.display;

		var gbn = "";
		if (dsp1=="" || dsp1=="block") gbn = "A";
		else if (dsp2=="" || dsp2=="block") gbn = "B";
		else if (dsp3=="" || dsp3=="block") gbn = "C";

		if (gbn=="A")	{
			if (LINE_PART.Enable==false) return;

			if(!Master_DataCheck()){return false ; }

			if (!confirm("�ۼ����� �ֹ������� �����Ͻðڽ��ϱ� ?"))	return;

			if(ls_start == true){
				var ls_yymm =  ETD_DT.Text.substring(2,6) ; 
				gcDs_etc0.DataID = g_dirPath+"/servlet/transfer.dsGetSeqNo?NOH=Y&gstr1=0001&gstr2=" + ls_yymm;  // �ֹ���ȣ Load
				gcDs_etc0.Reset();   
				gs_ordno = 'O' + ls_yymm +  gcDs_etc0.NameValue(1,"SEQ_NO")  ; 

			}

			var sval = gcDs1.NameValue(1,"PL_TYPE");
			sval = strim(sval);
			if (sval!="Y") gcDs1.NameValue(1,"PL_TYPE") = "N";
			gcDs1.NameValue(1,"CREATE_USR")	= gusrid;

			var ls_gbn = CARGO_TYPE.ValueOfIndex("MINORCD", CARGO_TYPE.index);
			if (ls_gbn != "0002")	{ //ȥ�簡 �ƴ� ���
				for (var s=1;s<=gcDs4.countrow ; s++) {
					if (s==1){
					//	if (gcDs4.sysStatus(s)=="1") { //�ֹ���Ͽ��� �������� �����Ҷ� �����ʵ� ���� �������� �����ǰԲ�...2008.2.20 ���� /�̹���
							gcDs4.NameValue(s,"EDT_DATE")	= gcDs1.NameValue(1,"ETD_DT");
							gcDs4.NameValue(s,"LINE_PART")	= gcDs1.NameValue(1,"LINE_PART");
							gcDs4.NameValue(s,"CREATE_USR")	= gusrid;
							gcDs2.NameValue(s,"ETD_DT")		= gcDs1.NameValue(1,"ETD_DT"); // �ֹ���Ͽ��� �������� �����Ҷ� �ֹ������ϵ� ���� �������� �����ǰԲ�..2008.2.21 ����/�̹���
	
						//}
					} else {
						//if (gcDs4.sysStatus(s)=="1") {
							gcDs4.NameValue(s,"EDT_DATE")		= ETD_DT.text;
							gcDs4.NameValue(s,"LINE_PART")	= LINE_PART.bindColVal;
							gcDs4.namevalue(s,"ORDER_NO")		= gs_ordno;
							gcDs4.NameValue(s,"CREATE_USR")	= gusrid;
							gcDs2.NameValue(s,"ETD_DT")		= ETD_DT.text; // �ֹ���Ͽ��� �������� �����Ҷ� �ֹ������ϵ� ���� �������� �����ǰԲ�..2008.2.21 ����/�̹���

						//}
					}
				}
			} else {              
			    //ȥ���϶��� �������� ���������ϰ���. 2008.09.04
				for (var s=1;s<=gcDs4.countrow ; s++) {
					if (s==1){
							gcDs2.NameValue(s,"ETD_DT")		= gcDs1.NameValue(1,"ETD_DT"); // �ֹ���Ͽ��� �������� �����Ҷ� �ֹ������ϵ� ���� �������� �����ǰԲ�..2008.2.21 ����/�̹���
					} else {
							gcDs2.NameValue(s,"ETD_DT")		= ETD_DT.text; // �ֹ���Ͽ��� �������� �����Ҷ� �ֹ������ϵ� ���� �������� �����ǰԲ�..2008.2.21 ����/�̹���
					}
				}
				///////////////////////////////////////////////////

				gcDs4.UndoAll();
				
			}

			//prompt('gcDs1',gcDs1.text);
			//prompt('gcDs2',gcDs2.text);
			//prompt('gcDs3',gcDs3.text);
            //alert("trOrderRegMst2::");
			gcTr05.KeyValue = "trOrderRegMst2(I:USER=gcDs1,I:CAR=gcDs4,I:CAR3=gcDs2)";
			gcTr05.Action = g_dirPath+"/servlet/transfer.trOrderRegMst2";
			gcTr05.Parameters = "gstr1="+gs_ordno ; //�ֹ���ȣ 
			
			//prompt('gcDs1',gcDs1.text);
			//prompt('gcDs4',gcDs4.text);
			//prompt('gcDs2',gcDs2.text);
			
			gcTr05.post();

			ls_start = false ; 

		} else if (gbn=="B") {
			if (!confirm("�ۼ����� �ֹ� �������� �����Ͻðڽ��ϱ� ?"))	return;
			Detail_Save();
		} else if (gbn=="C") {
			if (!confirm("�ۼ����� ��ǰ ���������� �����Ͻðڽ��ϱ� ?"))	return;
			CarGoods_SAVE();
		}
	}



	function ln_HistBack(){
		var va1 = parent.topmenu.hid_va01.value;
		var va2 = parent.topmenu.hid_va02.value;
		var va3 = parent.topmenu.hid_va03.value;
		var va4 = parent.topmenu.hid_va04.value;
		var va5 = parent.topmenu.hid_va05.value;
		var va6 = parent.topmenu.hid_va06.value;
		//alert(va1);

		window.location.href="../../transfer/html/TR00114.html?rsh&"+va1+"&"+va2+"&"+va3+"&"+va4+"&"+va5+"&"+va6;
	}

	function ln_HistBack01(){
		var va1 = parent.topmenu.hid_va01.value;
		var va2 = parent.topmenu.hid_va02.value;
		var va3 = parent.topmenu.hid_va03.value;
		var va4 = parent.topmenu.hid_va04.value;
		var va5 = parent.topmenu.hid_va05.value;
		var va6 = parent.topmenu.hid_va06.value;
		//alert("va1::"+va1);
		//alert("va2::"+va2);
		//alert("va3::"+va3);
		//alert("va4::"+va4);

		window.location.href="../../transfer/html/TR00101.html?rsh&"+va1+"&"+va2+"&"+va3+"&"+va4+"&"+va5+"&"+va6;
	}


	function ln_HistBack2(){
		var va1 = parent.topmenu.hid_va01.value;
		var va2 = parent.topmenu.hid_va02.value;
		var va3 = parent.topmenu.hid_va03.value;
		var va4 = parent.topmenu.hid_va04.value;
		var va5 = parent.topmenu.hid_va05.value;
		var va6 = parent.topmenu.hid_va06.value;

		window.location.href="../../transfer/html/TR00214.html?rsh&"+va1+"&"+va2+"&"+va3+"&"+va4+"&"+va5+"&"+va6;
	}


