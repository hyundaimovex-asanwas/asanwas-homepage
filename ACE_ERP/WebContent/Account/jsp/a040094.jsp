<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : �о������ǥ���
 - ���α׷�ID 	 : a040094.jsp
 - J  S  P		     : a040094.jsp
 - �� �� ��		 : a040094_s1 
 - �� �� ��		 : ������
 - �� �� ��		 : 2013-05-31
 - �������		 : �о�����ϰ��� �� ������� ��ǥ ����.
 - [ �������� ][������] ����
 - [2013-05-31][������] �ű�
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>

<%@ page import="Account.common.*" %>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>


<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
  
    <jsp:include page="/Account/common/include/head.jsp"/>
	<title>�о������ǥ���</title>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
    var acc_dirpath=".";
    var g_arrParam	= new Array();
    
    var curdate = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
    var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid ���� 
		cfStyleGrid(getObjectFirst("gr_slipdtl"), "comn");  //grid ���� 
		
		fnInit();	
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
       
        //�����ڵ�[�˻�]
		gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
		gcds_fdcode.Reset();
		
		ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //���� 
		
		gclx_fdcode.bindcolval="02";
		lc_fdcode.bindcolval="02";
		
		//gcem_actyymm.text=gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
		//gcem_actyymm.text="201208" ;
		gcem_actyymm.text =fnGetbyymm(gs_date2);
		gcrd_gubun.codevalue="1";
		gcem_paydat.text = curdate ; 
		//gcem_paydat.text = "20120927" ; 	
		 
	    lc_fdcode.bindcolval = gfdcode;      
	    gcem_fs02.text ="A";
	    gcem_fsdat02.text =  curdate;
	    gcem_fsnbr02.text ="000000";      
	    gcem_actdat02.text = curdate;
    }
    
<%
 //****************************************************************************
// �������ϱ�
//****************************************************************************
%>
function fnGetbyymm(v_yyyymm) {

	var ls_yy = v_yyyymm.substring(0,4);
	var ls_mon = v_yyyymm.substring(4,6);
	var ls_bef_yyyymm="";
	var mm=0;
	
	if (ls_mon == "01") {
		ls_bef_yyyymm = parseInt(ls_yy,10)-1;
		ls_bef_yyyymm = ls_bef_yyyymm+"12";
	}else {
        mm =  parseInt(ls_mon,10)-1;
        if(mm<10){
        	ls_bef_yyyymm = ls_yy+"0"+mm;
        }else{
            ls_bef_yyyymm = ls_yy+mm;
        }
	}
	return(ls_bef_yyyymm);
}	
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    
       //��ȸ ����Ȯ�� 
        ds_default.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040094_s1"
									     + "?v_str1="+gclx_fdcode.BindColVal     
									 	 + "&v_str2="+gcem_actyymm.text           
										 + "&v_str3="+gcem_paydat.text       
										 + "&v_str4="+gcrd_gubun.codevalue;       
		 // prompt('', gcds_code01.DataID);				
		 ds_default.Reset();
		
        ds_slipdtl.ClearAll();
        fnDisplay_Clear();
	
    }    
    
    
       <%//clear %>
    function fnDisplay_Clear(){
        gcem_fsnum.text="";
    
    	gcem_fsrvalnm01.text ="";
		gcem_fsrvalnm03.text ="";
		gcem_fsrvalnm04.text ="";
		gcem_fsrvalnm05.text ="";
		gcem_fsrvalnm06.text ="";
		gcem_fsrvalnm07.text ="";
		gcem_fsrvalnm08.text ="";
		gcem_fsrvalnm09.text ="";
		
		txt_fsrefval01.value="";
		txt_fsrefval03.value="";
		txt_fsrefval04.value="";
		txt_fsrefval05.value="";
		txt_fsrefval06.value="";
		txt_fsrefval07.value="";
		txt_fsrefval08.value="";
		txt_fsrefval09.value="";
    }
     
        
    
    <%//��� %>
    function fnCancel_All(){
    	 fnSelect();
    	 fnRepay_Cancel_All();
    }
    
    
     <%//���� ��ü ���   %>
    function fnRepay_Cancel_All(){
    	gcds_banjae.clearAll();
		gcds_banjaemst.clearAll();
    }

    
     <%//��ǥ����%>
    function fnSlipCreate() {
    
          //DataSet Head ���� 
          //gs_rpt_mst.clearAll();

		  //var s_temp = "TITLE:STRING,COST_NM:STRING,USRNAME:STRING,USEDATE:STRING";
		  //gs_rpt_mst.SetDataHeader(s_temp);
		
		  //��ǥ MST ���� 
          
          //��ǥ DTL ���� 		  
		  
          //��ǥ REF ���� 
          
          //UPDATE -  �ⳳ���̺��� ��ǥ��ȣ INSERT ( �ⳳ������ �ⳳ SID ������ ������ �־�� ��. ) 
          //�������� ��ȸ �Ͽ� �ϰ� UPDATE ĥ��??
          //�ʼ��׸� üũ 
          
		//if(!fnSlipChk()) return;
		
		//1.ȸ������ 
		//2.����1, ����2 
		//3.�ŷ�ó 
		//4.���� 
		//5.���ް���, �ΰ����� 
		//6.�������� �ϰ�� ���곻�� ���� 
		//7.���곻�� �ݾ��հ� �������� �ݾ� �� 
		//8.��ǥ��Ͽ��� �ݾ��� ���� / �뺯 ���ÿ� �������� ���ϰ� ��. 
		
		// �⺻���� 
		//���ް��� -> �����ڵ� 1
		//���ް���+�ΰ����� --> �����ڵ� 2
		    
		ds_slipdtl.clearall();
		gcds_banjae.clearall(); //���� ���� �ʱ�ȭ 
		
		//�׸��� ������ ���� 
		fnCreateSelect();
	
    }
    
   <%//��ǥ������ ������ ��ȸ %>
    function fnCreateSelect() {
        var strfsdat = gcem_fs02.text +gcem_fsdat02.text;
        
        if(gcrd_gubun.codevalue==1){ 
	        ds_slipdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040094_s2"
			  					       + "?v_str1="+gclx_fdcode.BindColVal     
									   + "&v_str2="+gcem_actyymm.text           
									   + "&v_str3="+gcem_paydat.text       
									   + "&v_str4="+gcrd_gubun.codevalue
									   + "&v_str5="+strfsdat;       
			//prompt('',ds_slipdtl.DataID  );
			ds_slipdtl.Reset();
		}else if(gcrd_gubun.codevalue==2){
		
			 ds_slipdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040094_s3"
			  					       + "?v_str1="+gclx_fdcode.BindColVal     
									   + "&v_str2="+gcem_actyymm.text           
									   + "&v_str3="+gcem_paydat.text       
									   + "&v_str4="+gcrd_gubun.codevalue  
									   + "&v_str5="+strfsdat;       
			//prompt('',ds_slipdtl.DataID  );
			ds_slipdtl.Reset();
	    }
        
    }    
    
    <%//��ǥ��� �׸��� ������ �⺻����   %>
    function fnSlipdtl_Display(row){
    	var strPo="";
	    
	    //�ڵ������ϱ�
		for(var i=1;i<=row;i++){
			ds_slipdtl.namevalue(i,"FSNUM") =ln_Seqno_Format(Number(i),3);
			ds_slipdtl.namevalue(i,"FSSEQ") =ln_Seqno_Format(Number(i),5);
			ds_slipdtl.namevalue(i,"FSREFVAL02") =ds_slipdtl.namevalue(i,"VEND_CD") ;  
			ds_slipdtl.namevalue(i,"FSRVALNM02") =ds_slipdtl.namevalue(i,"VEND_NM") ;  
			
			//�μ� ( ���� ) 
			ds_slipdtl.namevalue(i,"FSREFVAL01") = "Y000";
			ds_slipdtl.namevalue(i,"FSRVALNM01") = "����";
					 
			
			//�����׸� 
			//�ܻ���Ա��� ��� 
			if (ds_slipdtl.namevalue(i,"ATCODE")=="2100110"){ 
				//�����׸� - �ܻ���Ա� 
				strPo="";
				strPo = fnRef_position_find(i,"1011");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "02";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "�Ϲݾ�ü";
			}else if (ds_slipdtl.namevalue(i,"ATCODE")=="2100510") {
				//�����׸� - �����ޱ� 
				strPo="";
				strPo = fnRef_position_find(i,"1013");
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "008";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "�Ϲݾ�ü";
			}else if(ds_slipdtl.namevalue(i,"ATCODE")=="1110150"){ //���뿹��
			
			    strPo="";
				strPo = fnRef_position_find(i,"0022");  //����
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "A00003";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "��ȯ���� �赿����";
			
			    strPo="";
				strPo = fnRef_position_find(i,"0023");  //���¹�ȣ
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0006";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "117-22-00428-2";
			}else if(ds_slipdtl.namevalue(i,"ATCODE")=="2100120"){  //�ܻ���Ա�(���޾���)
			
			    strPo="";
				strPo = fnRef_position_find(i,"0967");  //������ȣ
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "-";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = " -";
			
				strPo="";
				strPo = fnRef_position_find(i,"0022");  //����
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "A00003";
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "��ȯ���� �赿����";
				
				strPo="";
				strPo = fnRef_position_find(i,"0968");  //�������� = ��������
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"PAYDAT") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) =ds_slipdtl.namevalue(i,"PAYDAT") ;  
				
				strPo="";
				strPo = fnRef_position_find(i,"0969");  //��������
				ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = ds_slipdtl.namevalue(i,"FULDAT") ;  
				ds_slipdtl.namevalue(i,"FSRVALNM"+strPo)= ds_slipdtl.namevalue(i,"FULDAT") ;  
				
			}
			
			//��ȭ�� 
			strPo="";
			strPo = fnRef_position_find(i,"1043");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo)  = "01";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "WON";
			
			//��ȭ�ݾ� 
			strPo="";
			strPo = fnRef_position_find(i,"1045");
			ds_slipdtl.namevalue(i,"FSREFVAL"+strPo) = "0";
			ds_slipdtl.namevalue(i,"FSRVALNM"+strPo) = "0";
    	}
	}
	
    <%//������ �⺻ ������ ��ȸ  %>
    function fnSave() {
    
        gcds_acustpay.clearall();
		fnAcustpaySetDataHeader();
		fnAcustpaySetting();
       	
       	gcds_slipdtl.clearall();
		fnSlipdtlSetDataHeader();
		fnSlipdtlSettting();
       	
       	gcds_slipmst.clearall();
		fnSlipmstSetDataHeader();   
		fnSlipmstSettting();
    
     	//prompt('gcds_slipdtl',gcds_slipdtl.text);
     	//prompt('gcds_slipmst',gcds_slipmst.text);
    
     	if(fnSave_Chk()){
  			 if (gcds_slipmst.IsUpdated) {					
				 if(confirm("��ǥ�� �����Ͻðڽ��ϱ�?")){
					//gctr_code01.KeyValue = "Account.a040094_t1(I:USER=gcds_code01)";
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040094_t1?";
					tr2.Parameters="v_str1="+gusrid+",v_str2="+gfdcode;
					//prompt('gcds_slipmst',gcds_slipmst.text);
					//prompt('gcds_slipdtl',gcds_slipdtl.text);
					//prompt('gcds_banjae',gcds_banjae.text);
					//prompt('gcds_banjaemst',gcds_banjaemst.text);
					//prompt('gcds_acustpay',gcds_acustpay.text);
					//prompt('gcds_slipno',gcds_slipno.text);
					tr2.post();
			     }
			}
		}
    }

       
     <%//head����%>
	function fnSlipmstSetDataHeader() {
    	 var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
						   + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
						   + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
						   + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		  gcds_slipmst.SetDataHeader(s_temp);
     
    }
    
    <%//head����%>
	function fnSlipdtlSetDataHeader() {
	 	  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
		  				    + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
							+ "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							+ "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
							+ "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							+ "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							+ "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
							+ "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
							+ "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
							+ "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
							+ "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
							+ "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
							+ "TYPE01:STRING,TYPE02:STRING,TYPE03:STRING,TYPE04:STRING,TYPE05:STRING,"
							+ "TYPE06:STRING,TYPE07:STRING,TYPE08:STRING,TYPE09:STRING,"
							+ "ARBALDIV01:STRING,ARBALDIV02:STRING,ARBALDIV03:STRING,ARBALDIV04:STRING,ARBALDIV05:STRING,"
							+ "ARBALDIV06:STRING,ARBALDIV07:STRING,ARBALDIV08:STRING,ARBALDIV09:STRING,"
							+ "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
							+ "BANJAEYN:STRING,FSSTAT:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,"
							+ "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING";
			gcds_slipdtl.SetDataHeader(s_temp);
    }
    
    
     <%//head����%>
	function fnAcustpaySetDataHeader() {
    	 var s_temp = "FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,FSDAT:STRING,FSNBR:STRING";
		 gcds_acustpay.SetDataHeader(s_temp);
    }
      
        
     <%//��ǥdtl ������ ����%>
    function fnSlipdtlSettting() {
    	    	
    	for (var k=1;k<=ds_slipdtl.countrow;k++){
    		gcds_slipdtl.addrow();
    		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FDCODE" ) = ds_slipdtl.namevalue(k, "FDCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" )    = ds_slipdtl.namevalue(k, "FSDAT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNBR" )   = ds_slipdtl.namevalue(k, "FSNBR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSEQ" )   = ds_slipdtl.namevalue(k, "FSSEQ" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" ) = ds_slipdtl.namevalue(k, "ATCODE" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATDECR" ) = ds_slipdtl.namevalue(k, "ATDECR" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "REMARK" ) = ds_slipdtl.namevalue(k, "REMARK" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DEAMT" )   = ds_slipdtl.namevalue(k, "DEAMT" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CRAMT" )   = ds_slipdtl.namevalue(k, "CRAMT" );
       		
       		for(var no=1;no<=9;no++){
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFSEQ0"+no ) = ds_slipdtl.namevalue(k, "FSREFSEQ0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )   = ds_slipdtl.namevalue(k, "FSREFCD0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no )  = ds_slipdtl.namevalue(k, "FSREFVAL0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFNM0"+no )   = ds_slipdtl.namevalue(k, "FSREFNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no ) = ds_slipdtl.namevalue(k, "FSRVALNM0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "TYPE0"+no)           = ds_slipdtl.namevalue(k, "TYPE0"+no );
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ARBALDIV0"+no)    = ds_slipdtl.namevalue(k, "ARBALDIV0"+no );
       			
       			
       			//2012.10.02 ����ī���ϰ�� ����ī�� �ŷ�ó ���� 
       			/**����ī�� ���� ) 
	       		if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" )=="2100520"){
	       			if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )=="0029" ){
	       				gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no );
	       			}
	       		}
	       		**/
       		}
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )   = ds_slipdtl.namevalue(k, "DOCUMCD" );
       		
       		//������ ��� ���������� ��. 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )   ="01";
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRDT" )           =curdate;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRID" )            = gusrid;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEYN" )    = ds_slipdtl.namevalue(k, "ATDEBTYN" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSTAT" )        = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUVAL" )     = ds_slipdtl.namevalue(k, "DOCUVAL" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" )         = ds_slipdtl.namevalue(k, "FSNUM" );
       		
       		//�������� ó���� (������ ) 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DIVCD" )           ="Y000";
       		//����μ� ���� 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BGTDIV" )         = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEREF" )   = ds_slipdtl.namevalue(k, "BANJAEREF" );
       		
       	}
    } 
      
    <%//��ǥmst ������ ����%>
    function fnSlipmstSettting() {
    	var srow = 0;
		gcds_slipmst.addrow();
		
		srow = gcds_slipmst.rowposition; 
		
		//alert("FDCODE"+ds_slipdtl.namevalue(1, "FDCODE" ));
		
		gcds_slipmst.namevalue(srow,"FDCODE")= ds_slipdtl.namevalue(1, "FDCODE" );
		gcds_slipmst.namevalue(srow,"FSDAT") =  ds_slipdtl.namevalue(1, "FSDAT" );
		gcds_slipmst.namevalue(srow,"FSNBR")="000000";
		gcds_slipmst.namevalue(srow,"FSKND")= "D";            //�ڵ� - �������   
		gcds_slipmst.namevalue(srow,"FSWRTDAT")=curdate;
		gcds_slipmst.namevalue(srow,"COCODE")="02";
		gcds_slipmst.namevalue(srow,"DEPTCD")= gdeptcd;
		gcds_slipmst.namevalue(srow,"EMPNO")=gusrid;
		gcds_slipmst.namevalue(srow,"DIVCD")= "";
		gcds_slipmst.namevalue(srow,"FSAMT")= gcds_slipdtl.Sum(9,0,0);   //���� 
		gcds_slipmst.namevalue(srow,"FSVAT")= 0 ;
		gcds_slipmst.namevalue(srow,"DETOT")= gcds_slipdtl.Sum(9,0,0);   //���� 
		gcds_slipmst.namevalue(srow,"CRTOT")= gcds_slipdtl.Sum(10,0,0); //�뺯 
		gcds_slipmst.namevalue(srow,"REMARK")=  gcds_slipdtl.namevalue(1,"REMARK"); //�뺯 
		gcds_slipmst.namevalue(srow,"SGNDAT")= "";
		gcds_slipmst.namevalue(srow,"FSSTAT")= "N";
		gcds_slipmst.namevalue(srow,"ACTDAT")= gcem_actdat02.text;
		gcds_slipmst.namevalue(srow,"SSDAT")= "";
		gcds_slipmst.namevalue(srow,"SSNBR")= "";
		gcds_slipmst.namevalue(srow,"WRDT")=  curdate;
		gcds_slipmst.namevalue(srow,"WRID")= gusrid;
    
    } 
    
     <%//������ �⺻ ������ ��ȸ  %>
    function fnAcustpaySetting() {
    	for(var t=1;t<=ds_default.CountRow;t++){
    	    if(ds_default.namevalue(t,"ATKORNAM")!=""){
	    		gcds_acustpay.addrow();
	    		gcds_acustpay.namevalue(gcds_acustpay.rowposition,"FDCODE")= ds_default.namevalue(t,"FDCODE");
	    		gcds_acustpay.namevalue(gcds_acustpay.rowposition,"TSDAT")  = ds_default.namevalue(t,"TSDAT");
	    		gcds_acustpay.namevalue(gcds_acustpay.rowposition,"TSNBR")  = ds_default.namevalue(t,"TSNBR");
	    		gcds_acustpay.namevalue(gcds_acustpay.rowposition,"TSSEQ")  = ds_default.namevalue(t,"TSSEQ");
	    	}
    	}
   }
    
     <%//�ʼ��׸� üũ%>
     function fnSave_Chk(){
     
        //return true;
     
        var intBanjaeDeamt=0;
        var intBanjaeCramt=0;
     
	    //���� Ȯ�� 
		if(gcds_slipmst.namevalue(1,"FDCODE")==""){
			alert("������ Ȯ�� �Ͻʽÿ�");
			return false;
		}
		

		
		//�����հ� �� �뺯�հ� �� 
		if(gcds_slipmst.namevalue(1,"DETOT")!=gcds_slipmst.namevalue(1,"CRTOT")){
			alert("�����հ�� �뺯�հ� �ݾ���  Ȯ�� �Ͻʽÿ�");
			return false;
		}
		
		
		//��������
		if(gcds_slipmst.namevalue(1,"FSDAT")==""){
			alert("�������ڸ� Ȯ�� �Ͻʽÿ�");
			return false;
		}		
		
		
		//ȸ������ Ȯ��
		if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
			alert("ȸ�����ڸ� Ȯ�� �Ͻʽÿ�");
			return false;
		}		
		
		
		/**
		//�ⳳ����� ȸ�����̰� Ʋ����� 
		if (gcds_slipmst.namevalue(1,"ACTDAT").substring(0,6)!=vt_fr_inout_dt.text.substring(0,6)){
			alert("�ⳳ����� ȸ������ �ٸ��ϴ�. Ȯ�ιٶ��ϴ�.");
			return false;
		}
		**/
	

     	for(var i=1;i<=gcds_slipdtl.countrow;i++){
     	     	
     	    if(gcds_slipdtl.namevalue(i,"ATCODE")==""){
				 gcds_slipdtl.rowposition = i;
				 alert("�����ڵ带 �Է��Ͻʽÿ�");
				 return false;
			}
			
			//�ݾ�
			if(gcds_slipdtl.namevalue(i,"DEAMT")==0&&gcds_slipdtl.namevalue(i,"CRAMT")==0){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ݾ��� �Է��Ͻʽÿ�");
				return false;
			}
			
			//���� �� �뺯 �ݾ� 
			if(gcds_slipdtl.namevalue(i,"DEAMT")!=0&&gcds_slipdtl.namevalue(i,"CRAMT")!=0){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+ " �����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
				return false;
			} 
			
			
			 //�ŷ�ó 
			if(gcds_slipdtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL02")==""||gcds_slipdtl.namevalue(i,"FSRVALNM02")=="")){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ŷ�ó�� �ʼ��׸��Դϴ�.");
				return false;
			}
			
				//�μ� 
			if(gcds_slipdtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL01")==""||gcds_slipdtl.namevalue(i,"FSRVALNM01")=="")){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �μ��� �ʼ��׸��Դϴ�.");
				return false;
			}
	
			//����
			if(gcds_slipdtl.namevalue(i,"REMARK")==""){
				gcds_slipdtl.rowposition = i;
				alert(gcds_slipdtl.namevalue(i,"FSNUM")+" ������ �Է��Ͻʽÿ�");
				return false;
			}
		
     	
	     	if(gcds_slipdtl.namevalue(i,"DOCUMCD")!=""&&gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
	     		alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �������� ���� ���� �ʽ��ϴ�.");
	     		gcds_slipdtl.rowposition = i;
	     		return false;
	     	}
	     	
	  
			for(var k=3;k<=9;k++){
			   
					if(gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)=="")){	
							if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)!="0003"){
							
								 if(gcds_slipdtl.namevalue(i,"TYPE0"+k)!="C"){ //�Է¾ƴѰ�� 
								    ///alert("k::"+k+"::"+gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)+"::::FSREFVAL::"+gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)+"::FSRVALNM::"+gcds_slipdtl.namevalue(i,"FSRVALNM0"+k));
								    //�ʼ��׸� üũ 
									tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
									alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �����׸� "+tempnm+"�� �ʼ��׸��Դϴ�2.");
									gcds_slipdtl.rowposition = i;
									return false;		
								}else{
									if(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)==""){
										tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
										alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �����׸� "+tempnm+"�� �ʼ��׸��Դϴ�3.");
										gcds_slipdtl.rowposition = i;
										return false;		
									
									}
								}
							}
					 }
			}//for k
			
			
			 // ���� ������ (-)�ݾ�  �Է� ���� 	
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //����
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //����
						if(gcds_slipdtl.namevalue(i,"DEAMT")<0){
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
							gcds_slipdtl.rowposition = i;
							return false;
						}
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //�뺯
						if(gcds_slipdtl.namevalue(i,"CRAMT")<0){
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
							gcds_slipdtl.rowposition = i;
							return false;
						}
				 }
			}
			
			  //�ſ�ī��(����), ���ݿ�����(����)�� ��� ���޺ΰ���ġ���� ��Ÿ�ΰ����� �ƴϸ� üũ 
			 /*
			if(gcds_slipdtl.namevalue(i,"DOCUMCD")=="103"||gcds_slipdtl.namevalue(i,"DOCUMCD")=="104" ){ 
				for(var x=3;x<=9;x++){
					if(gcds_slipdtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //���޺ΰ���ġ��
						if(gcds_slipdtl.namevalue(i,"FSREFVAL0"+x)!="04"){
						    gcds_slipdtl.rowposition = i;
							alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �������� �ſ�ī��(����), ���ݿ�����(����)�� ��� ���޺ΰ���ġ�� �׸��� ��Ÿ�ΰ����Դϴ�. ");
							return false;
						}
					}
				}//for x
			}	
			*/
			
			
			//�����ݾ� ����
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //����
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //�������� ( �뺯�ݾ� �հ� )
				 	intBanjaeCramt+=gcds_slipdtl.namevalue(i,"CRAMT");
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //�뺯���� ( �������� �հ� )
				 	intBanjaeDeamt+=gcds_slipdtl.namevalue(i,"DEAMT");
				 }
			}
	    } //for i
	    
	    
	    //alert("gcds_banjae.Sum(13,0,0):::"+gcds_banjae.Sum(13,0,0)+"::intBanjaeDeamt::"+intBanjaeDeamt);

        if (gcds_banjae.CountRow>0){
		    //�����ݾ� �հ�  üũ  ( �������� �հ� Vs ��ǥ����� ���� ���� �ݾ� �հ� )
		    if ( gcds_banjae.Sum(13,0,0)!=intBanjaeDeamt){
		    	alert( "���� ���� �ݾ��� Ʋ���ϴ�.");
		    	return false;
		    }
		    
		    if ( gcds_banjae.Sum(14,0,0)!=intBanjaeCramt){
		    	alert( "���� �뺯 �ݾ��� Ʋ���ϴ�.");
		    	return false;
		    }
		 }else{
		 	if ( intBanjaeDeamt !=0){
		    	alert( "���� ���� �ݾ��� Ʋ���ϴ�2.");
		    	return false;
		    }
		    
		     if (intBanjaeCramt !=0){
		    	alert( "���� �뺯 �ݾ��� Ʋ���ϴ�2.");
		    	return false;
		    }
		 }
	    	
	    return  true;
     }
    
    
     <%//�����׸� ã�� %>
	function fnRef_Popup(p1,obj,strkeycode){
	
	    var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var strposition="";
		var strpo2="";
		var strpo3="";
		var strPopGubun ="";
		var strPo="";                  // �����׸���ġ
		var divcd="";
		var intp=0;                      //�����׸� ��ġ
		
		//var dirpath="../../Account/jsp";
		
		
		/////////////////////////////////////////////////////
		// �����׸� ������  ( �ŷ�ó ���� ) 
		/////////////////////////////////////////////////////
		intp = Number(p1);
		
		//alert(":::::::::::::::"+eval("txt_type0"+intp).value);
		if(eval("txt_type0"+intp).value=="C") return;
					
		arrParam[0] = eval("txt_fsrefcd"+p1).value;        //�����׸� �����ڵ�  
		arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //�����׸� �� 
		
		//ds_slipdtl.namevalue(row,"TYPE"+p)=="C"
		//alert("arrParam[0]::"+arrParam[0]);
			
		//�μ� 
		if (arrParam[0]=="0002"){
			arrParam[2]="A";
			arrParam[3]="";
			arrParam[4]=lc_fdcode.bindcolval;
	
			//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
		  var stractdat = gcem_actdat02.text;
		  arrParam[5]=stractdat.substring(0,6);
		
		   strURL = acc_dirpath+"/hcdept_popup.jsp";
		   strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";	   
		}else if (arrParam[0]=="0020"){
			strURL =  acc_dirpath+"/gczm_vender_popup.jsp";
			strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
		}else if (arrParam[0]=="0003"){//����μ� 
			arrParam[2]=hid_bgtdiv.value;
			strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="0030"){ //����
			arrParam[2]="";
			strURL = acc_dirpath+"/commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="1113"){//ī���ȣ 
			 arrParam[2]="";
		     for(p=3;p<=9;p++){
					if(eval("txt_fsrefcd0"+p).value=="1134"){
						arrParam[2]=eval("txt_fsrefval0"+p).value;
						break;
					}
			 }
			 strURL =  acc_dirpath+"/commdtil_popup_card.jsp";
			 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else if (arrParam[0]=="1135"){//�ڻ��ڵ��ȣ 
			arrParam[1]= lc_fdcode.bindcolval;   //����
			arrParam[2]= ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE");         //�����ڵ�
			strURL =  acc_dirpath+"/commdtil_popup_astnbr.jsp";
			strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		}else{
			 if(arrParam[0]=="0997")arrParam[2]="A";
			 strURL =  acc_dirpath+"/commdtil_popup_ifrm.jsp";
			 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
		}
	
		result = showModalDialog(strURL,arrParam,strPos);	
	
		if(result != null) {
			arrResult = result.split(";");
			eval("txt_fsrefval"+p1).value =arrResult[0];
			eval("gcem_fsrvalnm"+p1).text =arrResult[1];
			
			//alert("01::"+gcem_fsrvalnm01.text);
			//alert("02::"+gcem_fsrvalnm02.text);
			
			if (arrParam[0]=="0002"){
				hid_divcd.value = arrResult[3]; //����
			}
	    }	
	}
    

	<%//�����׸� KillFocus�� �߻�  obj - �����׸��� gcem object��    p - �ڸ��� 0 %>
	function fnonblur(obj, p){
	  // alert("obj::"+obj);
	    var row = ds_slipdtl.rowposition;
	    
	    if(obj=="gcem_fsrvalnm"+p){
			if(ds_slipdtl.namevalue(row,"TYPE"+p)=="C"){
				eval("txt_fsrefval"+p).value =eval("gcem_fsrvalnm"+p).text; 	
				//alert("07::::::::"+eval("txt_fsrefval"+p).value);
			}
			
			if(eval("gcem_fsrvalnm"+p).text==""){
				eval("txt_fsrefval"+p).value=""; 
			}
		}
	}
	    
    
     <%//�����׸� ��ġã��%>
    function fnRef_position_find(p,strValue){
	  var strposition="";
		for(f=3;f<=9;f++){
		    //alert("strValue::"+strValue+"::"+ds_slipdtl.namevalue(p,"FSREFCD0"+f)+"::");
			if (ds_slipdtl.namevalue(p,"FSREFCD0"+f)==strValue){  
					strposition ="0"+f;
					return strposition; 
		    }
		}//for f 
		return strposition; 
	}
     
    <%//���� �˾�%>
    function fnRepay(){
   
		var row = ds_slipdtl.rowposition;
		var result="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var strseq="000";
		var strbanjaeref ="";
		var strbanjaerefval ="";
		var strbanjaerefnm = "";
		
		
		//�����ݸ� ���� ���� ������ .
				
		
		//���� ����üũ 
		if (ds_slipdtl.namevalue (row,"ATDEBTYN")!="Y"){
			alert("���������� �ƴմϴ�.");
			return false;
		}
		
		
		//���������ε� ������ �ݾ� �����ϸ� ���� �ȵ� 
		if(ds_slipdtl.namevalue (row,"ATDECR")=="1"&&ds_slipdtl.namevalue (row,"DEAMT")!=0){
			alert("���� �߻����Դϴ�.");
			return false;
		}
		
		//�뺯�����ε� �뺯�� �ݾ��� �����ϸ� ���� �ȵ� 
		if(ds_slipdtl.namevalue (row,"ATDECR")=="2"&&ds_slipdtl.namevalue (row,"CRAMT")!=0){
			alert("���� �߻����Դϴ�.");
			return false;
		}
			

		//���� ���� �����Ͱ� �����ϸ� 
	    for(var m=1;m<=gcds_banjae.countrow;m++){
	    	if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(m,"BTSSEQ")){
	    		alert("���� �����Ͱ� �����մϴ�.");
	    		return false;
	    	}
	    }
	       
		//�������� �����׸��� ������.
		_out2:
		for(k=1;k<=9;k++){
		    //alert("row:::"+row+"::FSREFCD0:::"+ds_slipdtl.namevalue(row,"FSREFCD0"+k)+"::BANJAEREF::"+ds_slipdtl.namevalue(row,"BANJAEREF"));
			if(ds_slipdtl.namevalue(row,"FSREFCD0"+k)==ds_slipdtl.namevalue(row,"BANJAEREF")){
					 strbanjaeref = ds_slipdtl.namevalue(row,"BANJAEREF");
					 //alert("strbanjaeref::"+strbanjaeref);
					 strbanjaerefval = ds_slipdtl.namevalue(row,"FSREFVAL0"+k)
					 strbanjaerefnm = ds_slipdtl.namevalue(row,"FSRVALNM0"+k)
					 //alert("strbanjaerefval:;"+strbanjaerefval);
					 //alert("strbanjaerefnm:;"+strbanjaerefnm);
					 break _out2;
			}
		}//k	
		
	    g_arrParam[0]=ds_slipdtl.namevalue(row,"ATCODE");       //�����ڵ�
		g_arrParam[1]=ds_slipdtl.namevalue(row,"ATKORNAM");  //������
		g_arrParam[2]=ds_slipdtl.namevalue(row,"VEND_CD");     //�ŷ�ó�ڵ�
		g_arrParam[3]=ds_slipdtl.namevalue(row,"VEND_NM");    //�ŷ�ó��
		g_arrParam[4]=ds_slipdtl.namevalue(row,"FDCODE");	 //������ǥ FDCODE   FSDAT
		g_arrParam[5]=ds_slipdtl.namevalue(row,"FSDAT");	     //������ǥ FSDAT
		g_arrParam[6]=ds_slipdtl.namevalue(row,"FSNBR");		 //������ǥ FSNBR          
		g_arrParam[7]=ds_slipdtl.namevalue(row,"FSSEQ");       //��ǥ���ȣ seq
		g_arrParam[8]=strbanjaeref;                                           //�������� �����׸� 
		g_arrParam[9]=strbanjaerefval;                                       //����������
		g_arrParam[10]=strbanjaerefnm;                                      //���������� ��Ī
	
	   
	    //alert("strbanjaerefval::"+strbanjaerefval);
	    
		strURL = acc_dirpath+"/repay_popup_A.jsp";
		strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,window,strPos);
		
		if (result != null) {
			arrResult = result.split(";");
			if(arrResult[0]!=0){         //������ 0�� �ƴ� ��� �뺯 �ݾ�
				ds_slipdtl.namevalue(row,"CRAMT")=arrResult[0];
			}else if(arrResult[1]!=0){   //�뺯�� 0�� �ƴ� ��� ���� �ݾ�
				ds_slipdtl.namevalue(row,"DEAMT")=arrResult[1];
			}
		}
	}
	
    <%//�������%>
	function fnRepay_Cancel(){
	   //prompt('mst',gcds_banjaemst.text);
	   //prompt('rel',gcds_banjae.text);
	   var crow = ds_slipdtl.rowposition;
	   
	   //alert("crow::"+crow);
	   
	    //���� ����üũ 
		if (ds_slipdtl.namevalue (crow,"ATDEBTYN")!="Y"){
			alert("���������� �ƴմϴ�.");
			return false;
		}else{
		    //alert("ATDECR::"+ds_slipdtl.namevalue (crow,"ATDECR"));
		    //alert("DEAMT::"+ds_slipdtl.namevalue (crow,"DEAMT"));
		    //alert("CRAMT::"+ds_slipdtl.namevalue (crow,"CRAMT"));
			if(ds_slipdtl.namevalue (crow,"ATDECR")=="1" && ds_slipdtl.namevalue (crow,"DEAMT")!=0){          //�������� �߻� 
				 alert("������� �׸��� �ƴմϴ�.1");
				 return false;
			}else if(ds_slipdtl.namevalue (crow,"ATDECR")=="2" && ds_slipdtl.namevalue (crow,"CRAMT")!=0){ //�뺯���� �߻� 
			     alert("������� �׸��� �ƴմϴ�.2");
			     return false;
			}
		}
		
		//var banjae_cnt=0;
		
	    //������ ���� 
		for(var m=1;m<=gcds_banjae.countrow;m++){
		   // alert(":m:"+m+":FSSEQ:"+ds_slipdtl.namevalue(crow,"FSSEQ") +":BTSSEQ:"+gcds_banjae.namevalue(m,"BTSSEQ"))
			if(ds_slipdtl.namevalue(crow,"FSSEQ") == gcds_banjae.namevalue(m,"BTSSEQ")){
				gcds_banjae.RowMark(m)=1;
				//banjae_cnt+=1;
			}else{
				gcds_banjae.RowMark(m)=0;
			}
		}
		
		gcds_banjae.DeleteMarked();
		/*
		if(banjae_cnt==0){
			return false;
		}else{
			gcds_banjae.DeleteMarked();
		}
		*/
		
		//����MST ���� 
		for(var n=1;n<=gcds_banjaemst.countrow;n++){
			if(ds_slipdtl.namevalue(crow,"FSSEQ") == gcds_banjaemst.namevalue(n,"SEQ")){
			   // alert("n::"+n);
			    gcds_banjaemst.RowMark(n)=1;
			}else{
			    gcds_banjaemst.RowMark(n)=0;
			}
		}
		
		gcds_banjaemst.DeleteMarked();
		//gcds_banjae.clearAll();
		//gcds_banjaemst.clearAll();
		
		ds_slipdtl.namevalue(crow,"DEAMT")=0;
		ds_slipdtl.namevalue(crow,"CRAMT")=0; 
	}
	
    
     
     
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>


<script language=JavaScript for=tr2  event=OnSuccess()>
	var temp="";
	
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("��ǥ ������ ���������� �Ϸ�Ǿ����ϴ�.");
	fnSelect();
</script>


<script language=JavaScript for=tr2 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
			gr_default.ColumnProp('INOUT_DT','BgColor')= "FFCC66";	
		}
	</script>
	
	<script language=javascript for="ds_slipdtl" event="OnLoadCompleted(row)">
	    fnSlipdtl_Display(row);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm01 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('01','gcem_fsrvalnm01',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('03','gcem_fsrvalnm03',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('04','gcem_fsrvalnm04',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('05','gcem_fsrvalnm05',kcode);
	</script>
	
	
	<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('06','gcem_fsrvalnm06',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('07','gcem_fsrvalnm07',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('08','gcem_fsrvalnm08',kcode);
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
		if (kcode==13||kcode==113)fnRef_Popup('09','gcem_fsrvalnm09',kcode);
	</script>
	
	
	
	<!-- �μ� / �ŷ�ó / �����׸� -->
	<script language=JavaScript for=gcem_fsrvalnm01 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm01", '01');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm03", '03');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm04", '04');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm05", '05');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm06", '06');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm07", '07');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm08", '08');
	</script>
	
	<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
	  fnonblur("gcem_fsrvalnm09", '09');
	</script>
		
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>

<object  id=gcds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ȸ-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥ�� -->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥ�� �����-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥmst-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>>       <!--����-->
    <param name="SyncLoad"  value="True">
</object>

<!--����history -->
<object id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="+BTSSEQ">
</object>

<!--������ȣ -->
<object id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
     <PARAM NAME="SyncLoad" VALUE="true">
</object>

 <!--�����������-->
<object id=gcds_acustpay classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"    value="a040094_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_acustpay,O:USER5=gcds_slipno )"> 
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <!--<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onclick="fnPrint()">-->
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td align="center" class="text" width="70">����</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                      <object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											 style="position:relative;left:6px;top:1px;font-size:12px;width:100px;">
												<param name=ComboDataID		  value="gcds_fdcode">
												<param name=CBDataColumns	  value="FDCODE, FDNAME">
												<param name=SearchColumn		  value=FDNAME>
												<param name=ListExprFormat	      value="FDNAME^0^120">
												<param name=BindColumn			  value="FDCODE">
									  </object>
                                    </td>
                                    <td align="center" class="text" width="70">���ޱ���</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
											<param name=Cols	    value="2">
											<param name=Format	value="1^���� ,2^����">
										</object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">ȸ����</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                            <object id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
										<param name=Text				value="">
										<param name=Alignment      value=0>
										<param name=Border          value=true>
										<param name=Format           value="YYYY/MM">
										<param name=PromptChar   value="_">
										<param name=BackColor      value="#CCCCCC">
										<param name=InheritColor    value=false>
										</object>
			                            <%=HDConstant.COMMENT_END%>        
			                            <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">                                                                       
			                        </td>   
			                        <td align="center" class="text" width="70">��������</td>
                                    <td bgcolor='#ffffff' >&nbsp;
									   	<comment id="__NSID__">
										<OBJECT id=gcem_paydat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
										<param name=Alignment		  value=0>
										<param name=Border	          value=true>
										<param name=Format	          value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
										<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
									</td>
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td><b><font size="2" color="blue">[�о��������]</font></b></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='170px' border='1'>
                                <param name="DataID"                  value="ds_default">
                                <param name="ColSizing"              value="true">
                                <param name="Editable"                value="false">
                                <param name="BorderStyle"          value="0">
                                <param name="fillarea"		        value="true">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                 value="
                                     <C>Id=Count name='CurLevel' width=80 Align=Right  Value={CurLevel}  show =false</C>
                                     <C> name='����'	            ID='GUBUN'    	         width=40 	align=center	 sumtext='��'</C>
                                     <C> name='�����ڵ�'       ID='ATCODE'       	     width=60 	align=center      sumtext='@cnt' sumtextalign='center'       </C>
                                     <C> name='������'		    ID='ATKORNAM' 		 width=73 	align=left      	 sumtext='��'     sumtextalign='center'       BgColor={IF(CurLevel=0,'#FFFFFF','#FFCC66')} </C>
									 <C> name='�ŷ�ó' 	        ID='VENDCD'             width=60 	    align=left       	 </C>
									 <C> name='�ŷ�ó��' 	    ID='VENDNM'    	     width=120 	align=left      	 </C>
                                     <C> name='���ޱݾ�'  	ID='JANAMT'              width=80 	align=right 		 sumtext='@sum'  </C>
                                     <C> name='ȸ������'      ID='ACTDAT'   	         width=65 	align=center      mask ='XXXX/XX/XX' </C>
                                     <C> name='��������'      ID='PAYDAT'   	         width=65 	align=center   	 mask ='XXXX/XX/XX' </C>
                                     <C> name='����'            ID='REMARK'      	     width=170 	align=left  	    </C>
                                     <C> name='��������'      ID='FULDAT'      	     width=65  	align=center  	 mask ='XXXX/XX/XX'</C>                                     
                                     <C> name='����'	           ID='FDCODE'    	          width=80 	align=center 	</C>
                                     <C> name='��������'	   ID='FSDAT'    	          width=80 	align=center 	</C>
                                     <C> name='������ȣ'      ID='FSNBR'    	          width=80 	align=center 	</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
         <tr height='25px'>
            <td>
            	 <table border='0' cellpadding='0' cellspacing='2' width='845px'>
                    <tr>
                        <td><b><font size="2" color="blue">[��ǥ���]</font></b></td>
                        <td height='20px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:hand" onclick="fnSlipCreate()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		    style="cursor:hand" onclick="fnSave()">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" onclick="fnCancel_All()">                        
						   
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='25px'>
	    	<td>
	    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
	    			<tr>
	                    <td align="center" class="text" width="70">����</td>                                                                     
	                   <td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_fdcode>
								<param name=BindColumn       value="FDCODE">
								<param name=BindColVal         value="FDCODE">
								<param name=ListExprFormat   value="FDNAME^0^90">
								<param name=Index                  value="2">
								<param name=Enable               value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
	                    <td align="center" class="text" width="70">������ȣ</td>
	                    <td bgcolor="#FFFFFF">&nbsp;
	                      	<%=HDConstant.COMMENT_START%>
							<object id=gcem_fs02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=Format        value="#">
							<param name=PromptChar    value="_">
							<param name=UpperFlag     value=1>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:70px;height:20px;position:relative;left:0px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="YYYY/MM/DD">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							-&nbsp;
							<object id=gcem_fsnbr02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:50px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="######">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							<%=HDConstant.COMMENT_END%>   
	                    </td>
	                     <td align="center" class="text" width="70">ȸ������</td>                                                                     
	                    <td bgcolor="#FFFFFF" >&nbsp;
	                    	<%=HDConstant.COMMENT_START%>
							<object id=gcem_actdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="position:relative;top:2px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							<%=HDConstant.COMMENT_END%>   
	                    </td>
	    			</tr>
	       		</table>
	       	</td>
	 	</tr>
   
        <tr>
        	<td>
	        	<table cellpadding="0" cellspacing="0" border="0" style="width:845px;height:200px;font-size:9pt;background-color:#ffffff;" > 
					<tr>
						<td colspan =9 style="height:145px;">
							<%=HDConstant.COMMENT_START%>
								<object id=gr_slipdtl classid=<%=HDConstant.CT_GRID_CLSID%> width='843px' height='170px' border='1'>
									<param name="dataid"			        value="ds_slipdtl">
									<param name="indwidth"		        value ='0'>
									<param name="borderstyle"         value="0">
									<param name="fillarea"		        value="true">
									<param name="ViewSummary"	value=1>
									<param name="ColSizing"            value="true">
									<param name="Editable"              value="true">
									<param name="ColSelect"		    value=false>
									<param name="Format"		  	    value=" 
									    <FC>Name='����'		   ID=FSNUM 	          Width=30	    align=center  edit=none    </FC> 
										<FC>Name='�����ڵ�'  ID=ATCODE 	          Width=51        align=left	    edit=none   </FC> 
										<FC>Name='������'	   ID=ATKORNAM	      Width=125	    align=left	    edit=none   SumText='��   ��'</FC> 
										<FC>Name='�����ݾ�'  ID=DEAMT 	          Width=95        align=right	edit=none   SumText={sum(Number(DEAMT))}  color =#0000FF  sumcolor =#0000FF  Value={Number(DEAMT)} </FC> 
										<FC>Name='�뺯�ݾ�'  ID=CRAMT 	          Width=95	    align=right    edit=none   SumText={sum(Number(CRAMT))}  color =#FF0000  sumcolor =#FF0000  Value={Number(CRAMT)}</FC> 										
										<C> Name='����'		   ID=REMARK              Width=250	    align=left	    SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
										<C> Name='������'	   ID=DOCUMCD 	       Width=70	    align=left       edit=none   SumText='����-�뺯'  EditStyle=Combo Data='000:,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����' show=false</C> 
										<C> Name='����'	       ID=DOCUVAL     	   Width=40    	align=left       edit=none   show = false</C> 
										<C> Name='����'		   ID=FSWRKDIV 	       Width=40	    align=center edit=none   EditStyle=Combo Data='01:������,02:����'  show =false</C> 
										<C> Name='�ŷ�ó'	   ID=VEND_NM     	   Width=140 	align=left       edit=none   </C> 
										<C> Name='�μ�'		   ID=FSRVALNM01 	   Width=50	    align=left       edit=none   </C> 
										<C> Name='�����׸�3' ID=FSRVALNM03 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�4' ID=FSRVALNM04 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�5' ID=FSRVALNM05 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�6' ID=FSRVALNM06 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�7' ID=FSRVALNM07 	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�8' ID=FSRVALNM08	   Width=100 	align=left	     edit=none   </C> 
										<C> Name='�����׸�9' ID=FSRVALNM09 	   Width=100 	align=left	     edit=none   </C>
									">
							</object><%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
					<tr>
					    <td width="25px"   class="tab32"     align=center  bgcolor="#B9D4DC" style="height:20px;" >����</td>
					    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
					    	<input type=text       id=txt_fsrefnm01   name=txt_fsrefnm01  value="�μ�"          size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					        <input type=hidden  id=txt_fsrefcd01   value=''>
							<input type=hidden  id=txt_fsrefseq01 value=''>
							<input type=hidden  id=txt_type01       value=''>
							<input type=hidden  id=txt_arbaldiv01 value=''>
					    </td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
							<input type=text    id=txt_fsrefnm03   name=txt_fsrefnm03  value="�����׸�3"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd03   value=''>
							<input type=hidden  id=txt_fsrefseq03 value=''>
							<input type=hidden  id=txt_type03       value=''>
							<input type=hidden  id=txt_arbaldiv03 value=''>					
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm04   name=txt_fsrefnm04  value="�����׸�4"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd04   value=''>
							<input type=hidden  id=txt_fsrefseq04 value=''>
							<input type=hidden  id=txt_type04       value=''>
							<input type=hidden  id=txt_arbaldiv04 value=''>
						</td>
						
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm05   name=txt_fsrefnm05  value="�����׸�5"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd05   value=''>
							<input type=hidden  id=txt_fsrefseq05 value=''>
							<input type=hidden  id=txt_type05       value=''>
							<input type=hidden  id=txt_arbaldiv05 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text       id=txt_fsrefnm06   name=txt_fsrefnm06  value="�����׸�6"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd06   value=''>
							<input type=hidden  id=txt_fsrefseq06 value=''>
							<input type=hidden  id=txt_type06       value=''>
							<input type=hidden  id=txt_arbaldiv06 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text        id=txt_fsrefnm07   name=txt_fsrefnm07  value="�����׸�7"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd07   value=''>
							<input type=hidden  id=txt_fsrefseq07 value=''>
							<input type=hidden  id=txt_type07       value=''>
							<input type=hidden  id=txt_arbaldiv07 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text        id=txt_fsrefnm08   name=txt_fsrefnm08  value="�����׸�8"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd08   value=''>
							<input type=hidden  id=txt_fsrefseq08 value=''>
							<input type=hidden  id=txt_type08       value=''>
							<input type=hidden  id=txt_arbaldiv08 value=''>
						</td>
						<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						    <input type=text    id=txt_fsrefnm09   name=txt_fsrefnm09  value="�����׸�9"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
						    <input type=hidden  id=txt_fsrefcd09   value=''>
							<input type=hidden  id=txt_fsrefseq09 value=''>
							<input type=hidden  id=txt_type09       value=''>
							<input type=hidden  id=txt_arbaldiv09 value=''>
							
							<input type=hidden  id=hid_banjaeref    value=''><!--��������-->
							<input type=hidden  id=hid_banjaeyn    value=''><!--��������-->
							<input type=hidden  id=hid_atdecr         value=''><!--���뱸��-->
							<input type=hidden  id=hid_bgtdiv          value=''><!--����-->
							<input type=hidden  id=hid_divcd           value=''><!--����-->
							<!--�ŷ�ó-->
							<input type=hidden  id=txt_fsrefcd02   value=''>
							<input type=hidden  id=txt_fsrefseq02 value=''>
							<input type=hidden  id=txt_type02       value=''>
							<input type=hidden  id=txt_arbaldiv02 value=''>
						</td>
					</tr>	
					<tr>
					    <td width="24px"   class="tab25"   align=center  style="height:22px;" >
					       <%=HDConstant.COMMENT_START%>
					    	 <object id=gcem_fsnum         classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:18;position:relative;top:3px;">				
								<param name=Text				value="">
								<param name=Border          value=false>
							    <param name=Format          value="000">
								<param name=Enable          value=false>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor   value=false> 
							</object><%=HDConstant.COMMENT_END%>
					    </td>
					    <td width="104px" class="tab26"     align=center  >
					    	<%=HDConstant.COMMENT_START%>
					   	    <object id=gcem_fsrvalnm01  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval01   value=''>
					    </td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval03   value=''>
						</td>
						<td width="104px" class="tab26"     align=center > 
						    <%=HDConstant.COMMENT_START%>
						 	<object id=gcem_fsrvalnm04  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval04   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm05  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval05   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm06  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval06   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
						    <%=HDConstant.COMMENT_START%> 
							<object id=gcem_fsrvalnm07  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval07   value=''>
						</td>
						<td width="104px" class="tab26"     align=center >
			               <%=HDConstant.COMMENT_START%>  
							<object id=gcem_fsrvalnm08  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type=hidden  id=txt_fsrefval08   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center>
						    <%=HDConstant.COMMENT_START%>  
							<object id=gcem_fsrvalnm09  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          value=false>
							<param name=Format          value="">
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=true>
							</object><%=HDConstant.COMMENT_END%>
							<input type="hidden"  id=txt_fsrefval09   value=''>
						</td>	
						
					</tr>
				</table>
			</td>
		</tr>
        <tr height='10px'>
        	<td>
        	 <table border='0' cellpadding='0' cellspacing='2' width='845px'>
                    <tr>
                        <td><b><font size="2" color="blue">[��������]</font></b></td>
                        <td height='20px' align='right'>
                            <img src="../../Common/img/btn/com_btn_repay.gif"		         style="cursor:hand"   onClick="fnRepay()"  >	
                            <img src="../../Common/img/btn/com_btn_repay_cancel.gif"	 style="cursor:hand;"  onClick="fnRepay_Cancel()"  >
						</td>
                    </tr>
                </table>
             </td>
        </tr>
        <tr>
            <td>
           		 <%=HDConstant.COMMENT_START%>  
            	 <object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_banjaerel style="WIDTH:843px;HEIGHT:100px;border:1 solid #777777;display:block;">
							<param name="dataid"			  value="gcds_banjae">
							<param name="borderstyle"   value="0">
							<param name="indwidth"        value="0">
							<param name="fillarea"		  value="true">
							<param name="colsizing"      value="true">
							<param name="ViewSummary"	value=1>
							<param name="format"			  value="  
							<C>  Name='��ǥ����'   ID=BTSSEQ            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=center 	SumBgColor=#C3D0DB  </C>	
							<C>  Name='��ǥ����'   ID=SSDAT            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=center 	SumBgColor=#C3D0DB  </C>	
							<C>  Name='��ȣ'         ID=SSNBR           	              HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	    align=center 	SumBgColor=#C3D0DB  </C>		
							<C>  Name='��'            ID=FSNUM           	              HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center 	SumBgColor=#C3D0DB  SumText= '�հ�' </C>			  					
							<C>  Name='����'		    ID=BJDEAMT          	          HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=right        color =#0000FF   SumBgColor=#C3D0DB  sumcolor =#0000FF SumText={sum(Number(BJDEAMT))} </C>
							<C>  Name='�뺯'         ID=BJCRAMT                      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	    align=right	    color =#FF0000   SumBgColor=#C3D0DB  sumcolor =#FF0000 SumText={sum(Number(BJCRAMT))} </C>		
							<C>  Name='����'         ID=REMARK            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=333	    align=left   	    SumBgColor=#C3D0DB  </C>						
								">
					</object>
				<%=HDConstant.COMMENT_END%>	
            </td>
        </tr>
    </table>
     <%=HDConstant.COMMENT_START%>  
    <object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID        value=ds_slipdtl>
	<param name=BindInfo     value='  
	<C>Col=FDCODE           Ctrl=hid_fdcode   	     Param=value</C>
	<C>Col=FSDAT              Ctrl=hid_fsdat               Param=value</C>
    <C>Col=FSNBR              Ctrl=hid_fsnbr              Param=value</C>
	<C>Col=FSSEQ              Ctrl=hid_fsseq              Param=value</C>
	<C>Col=ATCODE            Ctrl=gcem_atcode02       Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02		 Param=Text</C>
	<C>Col=ATDECR            Ctrl=hid_atdecr	         Param=value</C>
	<C>Col=REMARK            Ctrl=gcem_remark02_1     Param=Text</C>
	<C>Col=CHAAMT            Ctrl=gcem_detot02  	     Param=Text</C>
	<C>Col=DAEAMT            Ctrl=gcem_crtot02        Param=Text</C>
	<C>Col=FSREFSEQ01      Ctrl=txt_fsrefseq01      Param=value</C>
	<C>Col=FSREFSEQ02      Ctrl=txt_fsrefseq02      Param=value</C>
	<C>Col=FSREFSEQ03      Ctrl=txt_fsrefseq03      Param=value</C>
	<C>Col=FSREFSEQ04      Ctrl=txt_fsrefseq04      Param=value</C>
	<C>Col=FSREFSEQ05      Ctrl=txt_fsrefseq05	     Param=value</C>
	<C>Col=FSREFSEQ06      Ctrl=txt_fsrefseq06      Param=value</C>
    <C>Col=FSREFSEQ07      Ctrl=txt_fsrefseq07      Param=value</C>
	<C>Col=FSREFSEQ08      Ctrl=txt_fsrefseq08      Param=value</C>
	<C>Col=FSREFSEQ09      Ctrl=txt_fsrefseq09      Param=value</C>
	<C>Col=FSREFCD01        Ctrl=txt_fsrefcd01		 Param=value</C>
	<C>Col=FSREFCD02        Ctrl=txt_fsrefcd02	   	 Param=value</C>
	<C>Col=FSREFCD03        Ctrl=txt_fsrefcd03     	 Param=value</C>
	<C>Col=FSREFCD04        Ctrl=txt_fsrefcd04	   	 Param=value</C>
	<C>Col=FSREFCD05        Ctrl=txt_fsrefcd05     	 Param=value</C>
	<C>Col=FSREFCD06        Ctrl=txt_fsrefcd06     	 Param=value</C>
	<C>Col=FSREFCD07        Ctrl=txt_fsrefcd07     	 Param=value</C>
	<C>Col=FSREFCD08        Ctrl=txt_fsrefcd08     	 Param=value</C>
	<C>Col=FSREFCD09        Ctrl=txt_fsrefcd09     	 Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_fsrefval01          Param=value</C>
    <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03          Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04          Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05          Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06		     Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	         Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08          Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	         Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01			 Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03			 Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04			 Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05			 Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06			 Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07			 Param=value</C>
    <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08			 Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09			 Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_fsrvalnm01     Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	 Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01              Ctrl=txt_type01				   Param=value</C>
	<C>Col=TYPE02              Ctrl=txt_type02				   Param=value</C>
	<C>Col=TYPE03              Ctrl=txt_type03				   Param=value</C>
    <C>Col=TYPE04              Ctrl=txt_type04				   Param=value</C>
	<C>Col=TYPE05              Ctrl=txt_type05				   Param=value</C>
	<C>Col=TYPE06              Ctrl=txt_type06				   Param=value</C>
	<C>Col=TYPE07              Ctrl=txt_type07				   Param=value</C>
	<C>Col=TYPE08              Ctrl=txt_type08				   Param=value</C>
	<C>Col=TYPE09              Ctrl=txt_type09				   Param=value</C>
	<C>Col=ARBALDIV1       Ctrl=txt_arbaldiv01	  Param=value</C>          
	<C>Col=ARBALDIV2       Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV3       Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV4       Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV5       Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV6       Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV7       Ctrl=txt_arbaldiv07	  Param=value</C>
	<C>Col=ARBALDIV8       Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV9       Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT                 Ctrl=hid_cnt                Param=value</C>
	<C>Col=DOCUMCD       Ctrl=gclx_documcd02 Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT           Ctrl=hid_fsstat             Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM            Ctrl=gcem_fsnum	       Param=Text</C>
	<C>Col=DIVCD              Ctrl=hid_divcd             Param=value</C>
    <C>Col=BGTDIV            Ctrl=hid_bgtdiv            Param=value</C>
	<C>Col=FUNDDIV          Ctrl=hid_funddiv           Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF          Ctrl=hid_lastref            Param=value</C>
	<C>Col=BANJAEMOD     Ctrl=hid_banjaemod    Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype      Param=value</C>
	'>
</object>

<%=HDConstant.COMMENT_END%>

</body>
</html>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		