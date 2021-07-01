<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/******************************************************************************
 - �ý��۸� 	 : ����ī�� ��볻�� ��ǥ���� Ȩ>PMS>����ī��>��ǥ ����>��ǥ ����
 * ���α׷�ID 	 : PMS/CC120I
 * J  S  P		 : cc120ijsp, GAUCE5.x
 * �� �� ��		 : Cc120I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-08-31
 * [ �������� ][������] ����
 * [2015-09-01][�ɵ���] ������ ���·� ������..Y-����Ϸ�,C-�������, N-������, R-�����û, B-�ݼ�
 *							������ ������ ȸ��/��ǥ��Ͽ���
 * [2015-09-03][�ɵ���] ����ó�� �߰� 
 * 							������ :103:�ſ�ī��(����)		 '000:		,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����' 
 * [2015-09-04][�ɵ���] ��ǥ ���� �� ������ȣ ������Ʈ �� �������� �����Ȳ, ������� ó�� ��Ȳ����..����
 *						�� TCC120(����|�ͼ����̺�)�� ������Ʈ.. (Cc120I_t1.java)
 *						��	���°��� ������Ʈ�ؾ� �ϴµ� ��;;; ������ ������ ���� �ϳ�..��;;;
 *						���� ���� ����: 387line �����ڵ忡 ���� �ϵ� �ڵ��ߴµ�. ���庸�� ó������.
 * [2015-11-24][�ɵ���] ����� ǥ��, �ͼ����� ��Ƽ ����Ʈ ��;;
 *						�ͼ����� ��� ��ǥ�� ���...�������� �ͼ������ڵ带 ������ �ϰ�
 *						ds_cus(������Ʈ�� ���� ds), ��ǥ ������ ��ȸ/���� ���� �� ���ľ� �Ѵ�.��-��
 *						���� ���� Ÿ�ֿ̹� �����ϴ� �� �� �����ѵ�.. ��;;
 * [2015-12-01][�ɵ���] ������(������)�� ��� ó���� ��ȸ �߰�
 * [2015-12-03][�ɵ���] �����ڵ尡 44�� �����ϰ� 10���� ������ ��� ���� = '����'���� �����ϱ��
 * [2016-01-08][�ɵ���] �׷�� = ��ǥ ����.. �����ϱ�
 *****************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%		
		// ContextPath ���� ����.
		String dirPath = request.getContextPath(); //HDASan
	
	   java.util.Calendar date = java.util.Calendar.getInstance();
	   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	   String lastday = m_today.format(date.getTime());//����
	   //date.set(java.util.Calendar.HOUR_OF_DAY, -24);//����
	   String firstday = m_today.format(date.getTime());
	   
	   firstday = DateUtil.getCurrentDate(8).substring(0,6)+"01";
	   lastday = DateUtil.getCurrentDate(8);
	   	
%>


<!-- HTML ���� : doctype�� html5�� �غ���? ��;;-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">


	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
    var acc_dirpath="<%=dirPath%>/Account/jsp";
    var g_arrParam	= new Array();

    
    
	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��	
		
		cfStyleGrid(getObjectFirst("gr_cul"), "comn");  //grid ����
		cfStyleGrid(getObjectFirst("gr_slipdtl"), "comn");  //grid ���� 
		
		fnInit();	
		
		
	}
	
	
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
    	
		v_job ="I";   
		
		vt_fr_inout_dt.Text = "<%=firstday%>";
		vt_to_inout_dt.Text = "<%=lastday%>";
		
		ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
		ds_fdcode.Reset();   //���� 
		   
		          
		v_empnmk.value=gusrnm;
		v_empno.value=gusrid;       
		lc_fdcode.bindcolval = gfdcode;      
		gcem_fs02.text ="A";
		gcem_fsdat02.text =  "<%=DateUtil.getCurrentDate(8)%>";
		gcem_fsnbr02.text ="000000";      
		gcem_actdat02.text =  "<%=DateUtil.getCurrentDate(8)%>";
       
       
    }
	
    <%//���� ��ȸ  %>
    function fnSelect() {
    	
    	
	    v_job="S";

	    var fr_date = vt_fr_inout_dt.Text.trim();
        var to_date = vt_to_inout_dt.Text.trim();
        
        
        if(fr_date.length!=8) {
            alert("�ŷ�����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        
        if(to_date.length!=8) {
            alert("�ŷ�����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
    	}
        
        
    	if( fr_date.substring(0,6)!= to_date.substring(0,6) ){
       		alert("��ȸ�� �ŷ������ �����ؾ� �մϴ�. ");
       		return false;
        }

	    
    	
		v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
           		+ ",dsType=1"
	            + ",v_frdt=" + fr_date
	            + ",v_todt=" + to_date
	            + ",v_empno =" + v_empno.value	;
		
		
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc120I",	 
		            "JSP(O:DS_CUL=ds_cul)",
		            v_param);
        
        tr_post(tr1);		<%//Cc120I ��ȸ�� �̿�%>
        
        ds_slipdtl.ClearAll();
        
        fnDisplay_Clear();
        
        ds_cus.ClearAll();
        
        
    }    
    
    
    
    <%//���� DS head����%>
	function fnCusHeader() {
		
		var s_temp = "ACQUIRE_SID:DECIMAL, PL_DEPT:STRING, ATCODE:STRING, FDCODE:STRING,FSDAT:STRING,FSNBR:STRING";
		
		ds_cus.SetDataHeader(s_temp);
		
    }

	
	
    <%//���� DS ������ �⺻���� : ds_cus �ε� �� %>
    function fnCus_Display(row){
    	
	    //������Ʈ ���·� ���� �ڵ������ϱ�
		for(var i=1;i<=row;i++){
			
			ds_cus.namevalue(i,"FSDAT") =gcem_fs02.text+ gcem_fsdat02.text;
			
    	}
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
    	
    }
    
    
    
    
    <%//���� ��- ��ȸ%>
    function fnSelCostPop_0(dirPath) {
    	
    	
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
        	
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
            
        } else {
        	
			fnSelCostCleanup_0();
			
        }               
        
    }
  
    
    
  
    function fnSelCostCleanup_0(){
    	
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
        
        
    } 

    
    
    
     <%//��ǥ���� ��ư%>
    function fnSlipCreate() {
    	
    	
    	if(ds_cul.countrow>0){
    		
    		var chkCnt = 0 ;
    		var rowPos = 0 ;
    		
    		
    		for(var i=1;i<=ds_cul.countrow;i++){
    			if(ds_cul.namevalue(i,"CHKYN")=="T"){
    				chkCnt += 1;
    				rowPos = i ;	// üũ�� �ο� ������ ����
    			}
    		}
    		
    		
    		//alert(ds_cul.RowPosition);
    		//alert(rowPos);
			//if(ds_cul.namevalue(ds_cul.RowPosition,"FSDN")!=""){//��ǥ ������ȣ�� �̹� ������
			//	alert("��ǥ�� ����� �����Դϴ�.");
			
			
			
			if(chkCnt==0){
				
				alert("������ [ó�� �׷��]�� ������ �ֽʽÿ�.");
				
			}else if(chkCnt>1){
				
				alert("�� ���� 1���� [ó�� �׷��]�� �����Ͻø� �˴ϴ�.");
				
			}else{
				
				ds_slipdtl.clearall();
				//�׸��� ������ ����

				fnSelectTCC120(rowPos);	<%//��ǥ ���� �� TCC120 ��ǥ ������ȣ ������Ʈ�� ���� DS ��ȸ 20150904 �ɵ���%>

				fnCreateSelect(rowPos);	<%//��ǥ������ ��ȸ%>

			}
			
			
		}else{
			
			alert("����ī�� �ŷ� ó�������� ���� ��ȸ���ּ���.");
			
		}
			
    }
    	
    	
    	
    	
    	
    <%//���� DS ��ȸ : ȭ�鿡 �Ⱥ��� (20150904)%>
    function fnSelectTCC120(rowPos){
    	
    	
    	fnCusHeader();
    	
    	
	    var fr_date = vt_fr_inout_dt.Text.trim();
        var to_date = vt_to_inout_dt.Text.trim();
        var strFsdat = gcem_fs02.text+ gcem_fsdat02.text;
        
        
        /*var pl_depts = "";
        //�ͼӺμ� ��н�, ��Ƽ����Ʈ �ͼ� ����
		for(var i=1;i<=ds_cul.countrow;i++){
			if(ds_cul.namevalue(i,"CHKYN")=="T"){
				pl_depts += ds_cul.namevalue(i,"PL_DEPT") + ":";
			}
		}
		pl_depts += "00";*/
		
		
		
		v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			    		+ ",dsType=1"
			    		+ ",v_fdcode=" + lc_fdcode.bindcolval
			            + ",v_fsdat=" + strFsdat
			            + ",v_frdt=" + fr_date
			            + ",v_todt=" + to_date
			            + ",v_empno =" + v_empno.value
			            //+ ",v_pl_dept=" + pl_depts
			            + ",v_group_nm=" + ds_cul.namevalue(rowPos,"GROUP_NM")
			            ;
		
		
	    ln_TRSetting(tr1, 
	        "<%=dirPath%><%=HDConstant.PATH_CC%>Cc120I",	 
	        "JSP(O:DS_CUS=ds_cus)",
	        v_param);
	    
	    tr_post(tr1);
	    
    }    
    
    
    
    
    function fnCreateSelect(rowPos) {
    
    	
       var fr_date = vt_fr_inout_dt.Text.trim();
	   var to_date = vt_to_inout_dt.Text.trim();
	   var strFsdat = gcem_fs02.text+ gcem_fsdat02.text;

	   //var group_nm_renewal = ds_cul.namevalue(rowPos,"GROUP_NM");
	   //group_nm_renewal = group_nm_renewal.replace(' ', '');
	   
       var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                         + ",v_fdcode=" + lc_fdcode.bindcolval
		                         + ",v_fsdat=" + strFsdat
		                         + ",v_frdt=" + fr_date
		                         + ",v_todt=" + to_date
		                         + ",v_empno=" + v_empno.value
		                         + ",v_group_nm=" + ds_cul.namevalue(rowPos,"GROUP_NM")
		                         + ",v_avgcnt=" + ds_cul.namevalue(rowPos,"AVGCNT")	//���ΰ�:�������� ��Ī ����
		                         ;
	                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc120I",
            "JSP(O:DS_SLIPDTL=ds_slipdtl)",
            param);
        
            //prompt('',param);
            
        tr_post(tr1);
        //prompt('',ds_slipdtl.text);

    }    
    
    
    
    
    
    <%//��ǥ��� �׸��� ������ �⺻���� : ds_slipdtl �ε� ��   %>
    function fnSlipdtl_Display(row){
    	
    	var strPo="";
	    
	    //�ڵ������ϱ�
		for(var i=1;i<=row;i++){
			ds_slipdtl.namevalue(i,"FSNUM") =ln_Seqno_Format(Number(i),3);
			ds_slipdtl.namevalue(i,"FSSEQ") =ln_Seqno_Format(Number(i),5);
			ds_slipdtl.namevalue(i,"FSREFVAL02") =ds_slipdtl.namevalue(i,"VEND_CD") ;
			ds_slipdtl.namevalue(i,"FSRVALNM02") =ds_slipdtl.namevalue(i,"VEND_NM") ;
			// ���⿡ ���� �ڵ尡 �־�����, ��κ� �������� �ҷ����� ������ ����
			// 20150901 �ɵ���
    	}
	    
	}
    
    
    
	
    <%//������ �⺻ ������ ��ȸ  %>
    function fnSave() {
    	

		//fnTacSetDataHeader();
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
  				 
				if (confirm("���� �Ͻðڽ��ϱ�?")){	
					
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_CC%>Cc120I_t1"
					
					tr2.Parameters = "v_str1="+gusrid+",v_str2="+gfdcode;
					
				    //<param name="KeyValue"    value="Si050I_t1(I:USER1=gcds_slipmst,I:USER2=gcds_slipdtl,I:USER3=gcds_banjaemst,I:USER4=gcds_banjae,I:USER5=gcds_salestac,O:USER9=gcds_slipno )">    
				    //tr2.keyvalue="Si050I_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_salestac,O:USER5=gcds_slipno )"; 
					//prompt('gcds_slipmst',gcds_slipmst.text);
					//prompt('gcds_slipdtl',gcds_slipdtl.text);
					//prompt('gcds_banjaemst',gcds_banjaemst.text);
					//prompt('gcds_banjae',gcds_banjae.text);
					//prompt('gcds_salestac',gcds_salestac.text);
				
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
    
	
	
	
    <%//head����- gcds_slipdtl%>
	function fnSlipdtlSetDataHeader() {
		
		
	 	  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
		  				    + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,DEAMT:DECIMAL,CRAMT:DECIMAL,"
							+ "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
							+ "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
							+ "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
							+ "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
							+ "FSREFVAL01:STRING(30),FSREFVAL02:STRING(30),FSREFVAL03:STRING(30),FSREFVAL04:STRING(30),FSREFVAL05:STRING(30),"
							+ "FSREFVAL06:STRING(30),FSREFVAL07:STRING(30),FSREFVAL08:STRING(30),FSREFVAL09:STRING(30),"
							+ "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
							+ "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
							+ "FSRVALNM01:STRING(30),FSRVALNM02:STRING(30),FSRVALNM03:STRING(30),FSRVALNM04:STRING(30),FSRVALNM05:STRING(30),"
							+ "FSRVALNM06:STRING(30),FSRVALNM07:STRING(30),FSRVALNM08:STRING(30),FSRVALNM09:STRING(30),"
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
	       		if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" )=="2100520"){
	       			
	       			if(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD0"+no )=="0029" ){
	       				
	       				gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL0"+no ) = gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM0"+no );
	       				
	       			}
	       			
	       		}
       			
       		}
       		
       		
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )   = ds_slipdtl.namevalue(k, "DOCUMCD" );
       		
       		
       		
       		//����: ��� ���������� ��.- �ƾ� ���� �̰� �ƴϴ���. (__); 20150905 �ɵ���
       		//�ǸŰ������ 44�� �����ϰ� 10���� ������ �ɷ� �����ϱ�� : 20151203
       		//alert(ds_slipdtl.namevalue(k,"ATCODE").substring(0,2));
       		//alert(ds_slipdtl.namevalue(k,"ATCODE").substring(5,7));
       		//if(ds_slipdtl.namevalue(k,"ATCODE")=="4402110"||ds_slipdtl.namevalue(k,"ATCODE")=="4402410"||ds_slipdtl.namevalue(k,"ATCODE")=="4402810"){

       		if(ds_slipdtl.namevalue(k,"ATCODE").substring(0,3)=="440"){	//&&ds_slipdtl.namevalue(k,"ATCODE").substring(5,7)=="10"){
       			
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )   ="02";	//���� ����
       			
       		}else{
       			
       			gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )   ="01";	
       			
       		}
       		
       		
       		//alert(gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" ));
       		
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRDT" )        ="<%=DateUtil.getCurrentDate(8)%>";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "WRID" )        = gusrid;
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BANJAEYN" )    = ds_slipdtl.namevalue(k, "ATDEBTYN" );
       		
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSTAT" )      = "";
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUVAL" )     = ds_slipdtl.namevalue(k, "DOCUVAL" );
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" )       = ds_slipdtl.namevalue(k, "FSNUM" );
       		
       		//�����̴ϱ� ��� �Ǽ�������ΰ� ���ΰ� ��. 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DIVCD" )       ="II00";	// �� �̰͵� �������� ���� �� �� sdh
			//�׷��� ���� �̰ɷ� ����� �� �ʳ��ٰ� �� 20151216 ������� ��ȭ~
       		
       		
       		//����μ� ���� 
       		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "BGTDIV" )      = "";
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
		gcds_slipmst.namevalue(srow,"FSKND")= "D";         //�ڵ���ǥ - �繫ȸ��   
		gcds_slipmst.namevalue(srow,"FSWRTDAT")= "<%=DateUtil.getCurrentDate(8)%>";
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
		gcds_slipmst.namevalue(srow,"WRDT")=  "<%=DateUtil.getCurrentDate(8)%>";
		gcds_slipmst.namevalue(srow,"WRID")= gusrid;
    
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
		
		
		//ȸ������ Ȯ��
		if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
			
			alert("ȸ�����ڸ� Ȯ�� �Ͻʽÿ�");
			return false;
			
		}		
		
		
		//�ⳳ����� ȸ�����̰� Ʋ����� 
		if (gcds_slipmst.namevalue(1,"ACTDAT").substring(0,6)!=vt_fr_inout_dt.text.substring(0,6)){
			
			alert("�ŷ������ ȸ������ �ٸ��ϴ�. Ȯ�ιٶ��ϴ�.");
			return false;
			
		}
	

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
	     		
	     		alert(gcds_slipdtl.namevalue(i,"FSNUM")+" �������� ���� ���� �ʽ��ϴ�.\n\n���ó�� ȭ�鿡�� ���Ի����� �Ͻñ� �ٶ��ϴ�.");
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
			
			
			
			
			//�����ݾ� ����
			if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //����
				
				 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //�������� ( �뺯�ݾ� �հ� )
					 
				 	intBanjaeCramt+=gcds_slipdtl.namevalue(i,"CRAMT");
				 
				 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //�뺯���� ( �������� �հ� )
					 
				 	intBanjaeDeamt+=gcds_slipdtl.namevalue(i,"DEAMT");
				 
				 }
			
			}
			

			//2015.02.25.JYS (������ ��û) 
			//�ܻ���Ա�, �����ޱ��� �Ϲݾ�ü �� ���� �߻��� ��� ������ �ʼ� - ��꼭 ��ȣ Ȯ��
			///////////////////////////////////////////////////////////////////////////////////////////////////////
		   if(gcds_slipdtl.namevalue(i,"ATCODE")=="2100110"&&gcds_slipdtl.namevalue(i,"DEAMT")!=0){
			   
		    	m=0;
		    	
				for(k=3;k<=9;k++){

					if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)=="02"){
		        
						if(gcds_slipdtl.namevalue(i,"DOCUVAL")==""){
							
							gcds_slipdtl.rowposition = i;
							alert("�ܻ���Ա� �Ϲݾ�ü�� ������ȣ�� �ʼ��׸�ϴ�.Ȯ���Ͻʽÿ�");
							return false;
							
						}
						
				    }
					
		    	}
				
		    }	
			
	    } //for i
	    
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
		
		if(eval("txt_type0"+intp).value=="C") return;
					
		arrParam[0] = eval("txt_fsrefcd"+p1).value;    //�����׸� �����ڵ�  
		arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //�����׸� �� 
			

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
     
	
    
    
    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_empno.value = arrParam[1];
    		v_empnmk.value = arrParam[0];
    		
        } else {
        	
			fnEmpNoCleanup();
			
        }     
    	
    }

    
    function fnEmpNoCleanup(){
    	
		v_empno.value = "";
		v_empnmk.value = "";
		
    }
    
    
</script>



<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<script language=JavaScript for=vt_fr_inout_dt event=OnKillFocus()>
	
	        if( vt_fr_inout_dt.Modified == true )
	        	vt_to_inout_dt.text = vt_fr_inout_dt.text.substring(0,6)+"31";
	        
	</script>    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		
	}
	
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>


<script language=JavaScript for=tr2  event=OnSuccess()>

	var temp="";
	
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
	
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	
	fnSelect();
	
</script>


<script language=JavaScript for=tr2 event=OnFail()>

	alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");

</script>
 


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_cul event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
 
	<script language=javascript for="ds_cul" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
			//gr_cul.ColumnProp('INOUT_DT','BgColor')= "FFCC66";	
		}
	</script>
	
	
	<script language=javascript for="ds_cus" event="OnLoadCompleted(row)">
	    fnCus_Display(row);
	</script>


	<script language=javascript for="ds_slipdtl" event="OnLoadCompleted(row)">
	    fnSlipdtl_Display(row);
	</script>
	
	
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=vt_to_inout_dt event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
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
		if(ds_slipdtl.namevalue(ds_slipdtl.rowposition,"ATCODE")=="2100520"){ //�����ޱ�(����ī��)
			if(gcem_fsrvalnm07.Text.length>=9) {
				alert("����ī�� �ŷ�ó���� 8�ڱ��� �Է°����մϴ�.");
	      		gcem_fsrvalnm07.Text ="";
				gcem_fsrvalnm07.Focus();
	  		} 
	    }
		
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

<object id=ds_cul classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--�ŷ� ó������-->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥ��-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥ��-->
    <param name="SyncLoad"  value="true">
</object>

<object id=gcds_slipmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ǥmst-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_cardcode classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--���ι��� ī������-->
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_cardcode2 classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--����ī������-->
    <param name="SyncLoad"  value="true">
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

<!--�ŷ� ó�������� : ������ȣ ������ -->
<object id=ds_cus classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    	value="toinb_dataid4">
    <param name="ServerIP"     	value="">
    <param name="Action"        value="">
    <param name="KeyValue"     	value="">
    <param name="Parameters" 	value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    	value="toinb_dataid4">
    <param name="ServerIP"     	value="">
    <param name="Action"        value="">
    <param name="KeyValue"    	value="Cc120I_t1(I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=ds_cus,O:USER5=gcds_slipno )"> 
    <param name="Parameters" 	value="">
</object>


</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
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
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1002px'>
                                <tr>
			                        <td align="center" class="text" width="90">ó����</td>
                                    <td bgcolor='#ffffff' >&nbsp;
			                            <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  readOnly="readonly">
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                        	<% if("CC20".equals((String)session.getAttribute("vdeptcd"))){%>
			                        	<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
			                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
			                            <%}%>
									    
									</td>
			                        <td align=left class="text"  width="90">�ŷ�����</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                                                                                                         
			                        </td>   
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        
        <tr height='30px'>
            <td class="bold"><font size="2" color="blue">[����ī�� �ŷ� ó������]</font></td>
        </tr>
        
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_cul width="1000px" height="170px" border="1">
						        <param name="DataID"            value="ds_cul">
						        <param name="BorderStyle"       value="0">
						        <param name="ColSizing"         value="true">
						       	<param name="IndWidth"  		value="20">
						        <param name="editable"          value="true">
								<Param Name="UsingOneClick"     value="1">
						        <param name=SortView  			value="Left">
						        <param name="indwidth"			value="20">
						        <param name="SuppressOption"    value="1">
	        					<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
									<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
								">
						        <param name="Format"            value="
						        	<FC> name='Chk'				ID='CHKYN'   	width=30 		align=CENTER	HeadBgColor='#5C7CAC' edit=true editstyle=CheckBox </FC>
						        	<FC> name='ó�� �׷��'		ID='GROUP_NM'	width=140 		align=left 		HeadBgColor='#5C7CAC' suppress='1' edit=none </FC>
									<C> name='�ͼ�����'    		ID='PL_DEPT_NM' Width=170  		align=left 		suppress='2' edit=none </C>
					                <C> name='�ͼ��ڵ�'    		ID='PL_DEPT'  	Width=100  		align=center  	show=false  edit=none	</C>
					                <C> name='������'	  		ID='ATCODENM'   Width=150  		align=left  	show=true   edit=none</C>
					                <C> name='�����ڵ�'    		ID='ATCODE'    	Width=80  		align=left  	show=false  edit=none </C>
					                <C> name='�����'	  		ID='REFCDNM'   	Width=100  		align=left  	show=true   edit=none	</C>
					                <C> name='�����ڵ�'    		ID='REFCD'    	Width=80  		align=left  	show=false  edit=none </C>
					                <C> name='�̿�ݾ�'   		ID='TOT_TOTAL' 	Width=100  		align=RIGHT 	show=true	DEC=0  edit=none</C>
					                <C> name='���ް���' 		ID='AMT_NET'   	Width=100		align=RIGHT 	show=true	DEC=0  edit=none</C>
					                <C> name='����' 	 		ID='TOT_TAX'  	Width=80  		align=RIGHT 	show=true	DEC=0  edit=none</C>
					                <C> name='�����'   		ID='TOT_SVC'   	Width=80		align=RIGHT 	show=true	DEC=0  edit=none</C>
					                <C> name='Cnt'   			ID='AVGCNT'   	Width=30		align=RIGHT 	show=true	DEC=0  edit=none</C>
						        ">
							</object>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        
         <tr height='30px'>
            <td>
            	 <table border='0' cellpadding='0' cellspacing='2' width='1002px'>
                    <tr  height='20px'>
                        <td class="bold"><font size="2" color="blue">[��ǥ����]</font></td> 
                        <td class="r">
                            <img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:pointer" onclick="fnSlipCreate()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		    style="cursor:pointer" onclick="fnSave()">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"			style="cursor:pointer" onclick="fnCancel_All()">                        
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr height='30px'>
	    	<td>
	    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1002px'>
	    			<tr>
	                   <td align="center" class="text" width="90">����</td>                                                                     
	                   <td bgcolor='#ffffff'>&nbsp;&nbsp;

							<comment id="__NSID__">
								<object id=lc_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=100 border="0" align=absmiddle>
									<param name=ComboDataID     	value=ds_fdcode>
									<param name=BindColumn       	value="FDCODE">
									<param name=BindColVal          value="FDCODE">
									<param name=ListExprFormat   	value="FDNAME^0^90">
									<param name=Index               value="2">
									<param name=Enable              value="true">
								</object>
							</comment><script>__ws__(__NSID__);</script>                   

						</td>
						
	                    <td align="center" class="text" width="90">������ȣ</td>
	                    <td bgcolor="#FFFFFF">&nbsp;
							<object id=gcem_fs02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=Format        value="#">
							<param name=PromptChar    value="_">
							<param name=UpperFlag     value=1>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							<object id=gcem_fsdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:90px;height:20px;position:relative;left:0px;top:3px">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="YYYY/MM/DD">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
							-&nbsp;
							<object id=gcem_fsnbr02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="width:70px;height:20px;position:relative;left:0px;top:3px">				
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Format        value="######">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							</object>
	                    </td>
	                     
	                    <td align="center" class="text" width="90">ȸ������</td>                                                                     
	                    <td bgcolor="#FFFFFF" >&nbsp;
							<object id=gcem_actdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%> style="position:relative;top:2px;width:90px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
	                    </td>
	    			</tr>
	       		</table>
	       	</td>
	 	</tr>
   
   
        <tr>
        	<td>
	        	<table cellpadding="0" cellspacing="0" border="0" style="width:1002px;height:200px;font-size:9pt;background-color:#ffffff;" > 
					<tr>
						<td colspan =9 style="height:145px;">
							
								<object id=gr_slipdtl classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='240px' border='1'>
									<param name="dataid"			    value="ds_slipdtl">
									<param name="indwidth"		        value ='0'>
									<param name="borderstyle"         	value="0">
									<param name="fillarea"		        value="true">
									<param name="ViewSummary"			value=1>
									<param name="ColSizing"             value="true">
									<param name="Editable"              value="true">
									<param name="ColSelect"		    	value=false>
									<param name="Format"		  	    value=" 
									    <FC>Name='����'		   	ID=FSNUM 	       Width=30	    	align=center  	HeadBgColor='#5C7CAC' edit=none    </FC> 
										<FC>Name='�����ڵ�'  	ID=ATCODE 	       Width=60        	align=left	    HeadBgColor='#5C7CAC' edit=none   </FC> 
										<FC>Name='������'	   	ID=ATKORNAM	       Width=170	    align=left	    HeadBgColor='#5C7CAC' edit=none   SumText='��   ��'</FC> 
										<FC>Name='�����ݾ�'  	ID=DEAMT 	       Width=95        	align=right		HeadBgColor='#5C7CAC' edit=none   SumText={sum(Number(DEAMT))}  color =#0000FF  sumcolor =#0000FF  Value={Number(DEAMT)} </FC> 
										<FC>Name='�뺯�ݾ�'  	ID=CRAMT 	       Width=95	    	align=right    	HeadBgColor='#5C7CAC' edit=none   SumText={sum(Number(CRAMT))}  color =#FF0000  sumcolor =#FF0000  Value={Number(CRAMT)}</FC> 										
										<C> Name='����'		   	ID=REMARK          Width=205	    align=left	    SumText={sum(Number(CRAMT))-sum(Number(DEAMT))} SumTextAlign=right </C> 
										<C> Name='������'	   	ID=DOCUMCD 	       Width=70	    	align=left       edit=none   SumText='����-�뺯'  EditStyle=Combo Data='000:,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����'</C> 
										<C> Name='����'	       	ID=DOCUVAL     	   Width=40    		align=left       edit=none   </C> 
										<C> Name='����'		   	ID=FSWRKDIV 	   Width=40	    	align=center 	 edit=none   EditStyle=Combo Data='01:������,02:����'  show=false</C> 
										<C> Name='�ŷ�ó'	   	ID=VEND_NM     	   Width=100 		align=left       edit=none   </C> 
										<C> Name='�μ�'		   	ID=FSRVALNM01 	   Width=100	    align=left       edit=none   </C> 
										<C> Name='�����׸�3' 	ID=FSRVALNM03 	   Width=100 		align=left	     edit=none   </C> 
										<C> Name='�����׸�4' 	ID=FSRVALNM04 	   Width=100 		align=left	     edit=none   </C> 
										<C> Name='�����׸�5' 	ID=FSRVALNM05 	   Width=100 		align=left	     edit=none   </C>
										<C> Name='�����׸�6' 	ID=FSRVALNM06 	   Width=100 		align=left	     edit=none   </C> 
										<C> Name='�����׸�7' 	ID=FSRVALNM07 	   Width=100 		align=left	     edit=none   </C> 
										<C> Name='�����׸�8' 	ID=FSRVALNM08	   Width=100 		align=left	     edit=none   </C> 
										<C> Name='�����׸�9' 	ID=FSRVALNM09 	   Width=100 		align=left	     edit=none   </C>
										<C> Name='�����׸�5' 	ID=FSREFVAL05 	   Width=100 		align=left	     edit=none   show=false</C>
									">
							</object>		
						</td>
					</tr>
					
					<tr>
						<td>&nbsp;
						</td>
					</tr>
										
					<tr>
					    <td width="25px"   class="tab32"     align=center  bgcolor="#B9D4DC" style="height:20px;" >����</td>
					    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
					    	<input type=text    id=txt_fsrefnm01   name=txt_fsrefnm01  value="�μ�"          size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
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
					    	 <object id=gcem_fsnum         classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:18;position:relative;top:3px;">				
								<param name=Text			value="">
								<param name=Border          value=false>
							    <param name=Format          value="000">
								<param name=Enable          value=false>
								<param name=GeneralEdit   	value="true">
								<param name=BackColor     	value="#CCCCCC">
								<param name=InheritColor   	value=false> 
							</object>
					    </td>
					    
					    <td width="104px" class="tab26"     align=center  >
					   	    <object id=gcem_fsrvalnm01  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval01   value=''>
					    </td>
					    
						<td width="104px" class="tab26"     align=center >
							<object id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval03   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center > 
						 	<object id=gcem_fsrvalnm04  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval04   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center >
							<object id=gcem_fsrvalnm05  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval05   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center >
							<object id=gcem_fsrvalnm06  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval06   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center >
							<object id=gcem_fsrvalnm07  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval07   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center >
			                 
							<object id=gcem_fsrvalnm08  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type=hidden  id=txt_fsrefval08   value=''>
						</td>
						
						<td width="104px" class="tab26"     align=center>
							<object id=gcem_fsrvalnm09  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
							<param name=Text		        value="">
							<param name=Border          	value=false>
							<param name=Format          	value="">
							<param name=GeneralEdit   		value="true">
							<param name=BackColor     		value="#CCCCCC">
							<param name=InheritColor   		value=true>
							</object>
							<input type="hidden"  id=txt_fsrefval09   value=''>
						</td>	
						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="padding-top:4px;">�� �ڵ� ������ ��ǥ�� [<b>Ȩ>ȸ��>ȸ�����>��ǥ����>��ǥ���</b>]���� ������ȣ�� ��ȸ�� �� �ֽ��ϴ�.</td>
		</tr>		
    </table>
    
    
    
    <object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID        	value=ds_slipdtl>
	<param name=BindInfo     	value='  
	<C>Col=FDCODE           	Ctrl=hid_fdcode   	     	Param=value</C>
	<C>Col=FSDAT              	Ctrl=hid_fsdat         		Param=value</C>
    <C>Col=FSNBR              	Ctrl=hid_fsnbr         		Param=value</C>
	<C>Col=FSSEQ              	Ctrl=hid_fsseq         		Param=value</C>
	<C>Col=ATCODE            	Ctrl=gcem_atcode02      	Param=Text</C>
	<C>Col=ATKORNAM       		Ctrl=gcem_atkornam02		Param=Text</C>
	<C>Col=ATDECR            	Ctrl=hid_atdecr	     		Param=value</C>
	<C>Col=REMARK            	Ctrl=gcem_remark02_1    	Param=Text</C>
	<C>Col=CHAAMT            	Ctrl=gcem_detot02  	 		Param=Text</C>
	<C>Col=DAEAMT            	Ctrl=gcem_crtot02       	Param=Text</C>
	<C>Col=FSREFSEQ01      		Ctrl=txt_fsrefseq01      	Param=value</C>
	<C>Col=FSREFSEQ02      		Ctrl=txt_fsrefseq02      	Param=value</C>
	<C>Col=FSREFSEQ03      		Ctrl=txt_fsrefseq03      	Param=value</C>
	<C>Col=FSREFSEQ04      		Ctrl=txt_fsrefseq04      	Param=value</C>
	<C>Col=FSREFSEQ05      		Ctrl=txt_fsrefseq05	     	Param=value</C>
	<C>Col=FSREFSEQ06      		Ctrl=txt_fsrefseq06      	Param=value</C>
    <C>Col=FSREFSEQ07      		Ctrl=txt_fsrefseq07      	Param=value</C>
	<C>Col=FSREFSEQ08      		Ctrl=txt_fsrefseq08      	Param=value</C>
	<C>Col=FSREFSEQ09      		Ctrl=txt_fsrefseq09      	Param=value</C>
	<C>Col=FSREFCD01        	Ctrl=txt_fsrefcd01		 	Param=value</C>
	<C>Col=FSREFCD02        	Ctrl=txt_fsrefcd02	   	 	Param=value</C>
	<C>Col=FSREFCD03        	Ctrl=txt_fsrefcd03     	 	Param=value</C>
	<C>Col=FSREFCD04        	Ctrl=txt_fsrefcd04	   	 	Param=value</C>
	<C>Col=FSREFCD05        	Ctrl=txt_fsrefcd05     	 	Param=value</C>
	<C>Col=FSREFCD06        	Ctrl=txt_fsrefcd06     	 	Param=value</C>
	<C>Col=FSREFCD07        	Ctrl=txt_fsrefcd07     	 	Param=value</C>
	<C>Col=FSREFCD08        	Ctrl=txt_fsrefcd08     	 	Param=value</C>
	<C>Col=FSREFCD09        	Ctrl=txt_fsrefcd09     	 	Param=value</C>
	<C>Col=FSREFVAL01     		Ctrl=txt_fsrefval01         Param=value</C>
    <C>Col=FSREFVAL03     		Ctrl=txt_fsrefval03         Param=value</C>
	<C>Col=FSREFVAL04     		Ctrl=txt_fsrefval04         Param=value</C>
	<C>Col=FSREFVAL05     		Ctrl=txt_fsrefval05         Param=value</C>
	<C>Col=FSREFVAL06     		Ctrl=txt_fsrefval06		    Param=value</C>
	<C>Col=FSREFVAL07     		Ctrl=txt_fsrefval07	        Param=value</C>
	<C>Col=FSREFVAL08     		Ctrl=txt_fsrefval08         Param=value</C>
	<C>Col=FSREFVAL09     		Ctrl=txt_fsrefval09	        Param=value</C>
	<C>Col=FSREFNM01      		Ctrl=txt_fsrefnm01			Param=value</C>
	<C>Col=FSREFNM03      		Ctrl=txt_fsrefnm03			Param=value</C>
	<C>Col=FSREFNM04      		Ctrl=txt_fsrefnm04			Param=value</C>
	<C>Col=FSREFNM05      		Ctrl=txt_fsrefnm05			Param=value</C>
	<C>Col=FSREFNM06      		Ctrl=txt_fsrefnm06			Param=value</C>
	<C>Col=FSREFNM07      		Ctrl=txt_fsrefnm07			Param=value</C>
    <C>Col=FSREFNM08      		Ctrl=txt_fsrefnm08			Param=value</C>
	<C>Col=FSREFNM09      		Ctrl=txt_fsrefnm09			Param=value</C>
	<C>Col=FSRVALNM01     		Ctrl=gcem_fsrvalnm01     	Param=Text</C>
	<C>Col=FSRVALNM03     		Ctrl=gcem_fsrvalnm03	   	Param=Text</C>
	<C>Col=FSRVALNM04     		Ctrl=gcem_fsrvalnm04     	Param=Text</C>
	<C>Col=FSRVALNM05     		Ctrl=gcem_fsrvalnm05	 	Param=Text</C>
	<C>Col=FSRVALNM06     		Ctrl=gcem_fsrvalnm06     	Param=Text</C>
	<C>Col=FSRVALNM07     		Ctrl=gcem_fsrvalnm07     	Param=Text</C>
	<C>Col=FSRVALNM08     		Ctrl=gcem_fsrvalnm08     	Param=Text</C>
	<C>Col=FSRVALNM09     		Ctrl=gcem_fsrvalnm09     	Param=Text</C>
	<C>Col=TYPE01              	Ctrl=txt_type01				Param=value</C>
	<C>Col=TYPE02              	Ctrl=txt_type02				Param=value</C>
	<C>Col=TYPE03              	Ctrl=txt_type03				Param=value</C>
    <C>Col=TYPE04              	Ctrl=txt_type04				Param=value</C>
	<C>Col=TYPE05              	Ctrl=txt_type05				Param=value</C>
	<C>Col=TYPE06              	Ctrl=txt_type06				Param=value</C>
	<C>Col=TYPE07              	Ctrl=txt_type07				Param=value</C>
	<C>Col=TYPE08              	Ctrl=txt_type08				Param=value</C>
	<C>Col=TYPE09              	Ctrl=txt_type09				Param=value</C>
	<C>Col=ARBALDIV1       		Ctrl=txt_arbaldiv01	  		Param=value</C>          
	<C>Col=ARBALDIV2       		Ctrl=txt_arbaldiv02      	Param=value</C>
	<C>Col=ARBALDIV3       		Ctrl=txt_arbaldiv03      	Param=value</C>
	<C>Col=ARBALDIV4       		Ctrl=txt_arbaldiv04      	Param=value</C>
	<C>Col=ARBALDIV5       		Ctrl=txt_arbaldiv05      	Param=value</C>
	<C>Col=ARBALDIV6       		Ctrl=txt_arbaldiv06      	Param=value</C>
	<C>Col=ARBALDIV7       		Ctrl=txt_arbaldiv07	  		Param=value</C>
	<C>Col=ARBALDIV8       		Ctrl=txt_arbaldiv08      	Param=value</C>
    <C>Col=ARBALDIV9       		Ctrl=txt_arbaldiv09      	Param=value</C>
	<C>Col=CNT                 	Ctrl=hid_cnt                Param=value</C>
	<C>Col=DOCUMCD       		Ctrl=gclx_documcd02 		Param=BindColVal</C>
	<C>Col=BANJAEYN       		Ctrl=hid_banjaeyn        	Param=value</C>
	<C>Col=FSSTAT           	Ctrl=hid_fsstat             Param=value</C>
	<C>Col=DOCUVAL        		Ctrl=hid_docuval         	Param=value</C>
    <C>Col=FSNUM            	Ctrl=gcem_fsnum	       		Param=Text</C>
	<C>Col=DIVCD              	Ctrl=hid_divcd             	Param=value</C>
    <C>Col=BGTDIV            	Ctrl=hid_bgtdiv            	Param=value</C>
	<C>Col=FUNDDIV          	Ctrl=hid_funddiv           	Param=value</C>
	<C>Col=BANJAEREF      		Ctrl=hid_banjaeref       	Param=value</C>
	<C>Col=LASTREF          	Ctrl=hid_lastref            Param=value</C>
	<C>Col=BANJAEMOD     		Ctrl=hid_banjaemod    		Param=value</C>
	<C>Col=ATCURTYPE      		Ctrl=hid_atcurtype      	Param=value</C>
	'>
</object>


</body>
</html>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

