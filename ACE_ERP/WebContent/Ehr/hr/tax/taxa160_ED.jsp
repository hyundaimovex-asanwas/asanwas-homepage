<!--
***********************************************************************
* @source      : taxa160_ED.jsp
* @description : 근로소득원천징수영수증
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

	//String PIS_YYMM = request.getParameter("PIS_YYMM").substring(0,4);

	String PIS_YYMM    = request.getParameter("PIS_YYMM");
	String ENO_NO    = request.getParameter("ENO_NO");
	String DPT_CD    = request.getParameter("DPT_CD");
	//String STR_YMD    = request.getParameter("STR_YMD").replaceAll("-","");
	//String TYPE    = request.getParameter("TYPE");
	//String STP_GBN    = request.getParameter("STP_GBN");
     String TAX_GBN    =  request.getParameter("TAX_GBN");
	//String PRT_GBN    = request.getParameter("PRT_GBN");
	String CHK_OCC    =  "";  //request.getParameter("CHK_OCC");

    String sql = XmlSqlUtils.getSQL("tax2", "TAXB160_PRT");


    //param binding 하기
    Object[] bind = new Object[] {
    		PIS_YYMM,
    		PIS_YYMM,
    		PIS_YYMM,
    		ENO_NO,
    		CHK_OCC,
    	 	DPT_CD,
    	 	TAX_GBN,
    		PIS_YYMM,
    		PIS_YYMM
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
    String colStr = "ENO_NM,PIS_YY,ENO_NO,PIS_MM,OCC_CD,GBN_TAG,MDPT_CD,MJOB_CD,MHOB_CD,SOU_CNT,DFM_CNT,TRB_CNT,GOL_CNT,WCT_CNT,RCH_CNT,MHS_TAG,LIN_AMT,LMA_AMT,LF2_AMT,LED_AMT,LEF_AMT,LF1_AMT,LC3_AMT,LC2_AMT,LC1_AMT,LHO_AMT,LH1_AMT,LJH_AMT,LST_AMT,LJJ_AMT,LSQ_AMT,CLS_TAG,DOMW_DD,OUTW_DD,OTHW_CNT,TOTW_DD,DOMT_AMTS,OUTT_AMTS,DOMT_AMTB,OUTT_AMTB,SALT_AMTS,SALT_AMTB,SALT_AMTT,PAYD_AMTS,PAYO_AMTS,PAYD_AMTB,PAYO_AMTB,TAX_INCOME,YAB_INCOME,FREE_INCOME,SIM_TAX,ITXD_AMT,STAX_DED,INCM_TAX,CITI_TAX,SAV_SJH,HINU_AMT,NPEN_AMT,HINS_AMT,APP_AMT,MGR_AMT,MNI_AMT,BADD_AMT,SPSB_AMT,GDED_AMT,GOL_AMT,TBL_DED,WDD_AMT,MHS_AMT,RCH_AMT,SMD_AMT,PER_TOT,MIN_DED,MMA_DED,EDU_DED,HOS_DED,CPC_DED,NSE_TOT,PER_SAV,INDED_TOT,TTAX_STD,TAX_AMT,HGR_DED,STX_DED,HTX_DED,HSX_DED,OTX_DED,TAX_DED,TDED_TOT,DGG_TAX,DJM_TAX,DBW_TAX,AGG_TAX,AJM_TAX,DRE_INTX,DRE_CTTX,DRE_DFTX,DRE_LSN,FIN_SALT,RPT_YM,CARD_DED,CARD_AMT,LIN_DED,FLD_AMT,FLD_DED,VEN_AMT,VEN_DED,SPC_TOT,CONT_TAX,LIH_AMT,CHI_AMT,HIG_AMT,UNI_AMT,GRA_AMT,ANN_AMT,GOV_AMT,LON_AMT,LIH_DED,LSX_DED,GOV_DED,NPEN_DED,ANN_DED,HAN_AMT,AGE_AMT,STA_TOT,LON2_AMT,VEN2_AMT,LEN_AMT,HED_AMT,DIR_AMT,MHEA_AMT,OHEA_AMT,LEN_AMT2,LEN_AMT3,LEN_AMT4,LEN_AMT5,EDU_TAG1,EDU_AMT1,EDU_TAG2,EDU_AMT2,EDU_TAG3,EDU_AMT3,EDU_TAG4,EDU_AMT4,EDU_TAG5,EDU_AMT5,WED_CNT,MOV_CNT,FUN_CNT,GOL_CNT70,GOL_CNT65,GOV_AMT04,LH2_AMT04,LH2_AMT,LH4_AMT,LH7_AMT,LH8_AMT,GOL_AMT70,GOL_AMT65,CHI_DED,HIG_DED,UNI_DED,WFM_DED,LH3_AMT,SEA_FREE,CASH_AMT,GIRO_AMT,LC3_NTS,GOV_NTS,LC1_NTS,LC2_NTS,IPT_MAN,IPT_YMD,UPT_MAN,UPT_YMD,TAX_DPT,JAO_NO1,JAS_NM1,JAA_AMT1,JAB_AMT1,JAC_AMT1,JAD_AMT1,JAE_AMT1,JAF_AMT1,JAG_AMT1,JAH_AMT1,JAJ_AMT1,JAK_AMT1,JAL_AMT1,JAN_AMT1,JAM_AMT1,JAP_AMT1,JAQ_AMT1,SEQ_NO1,JAI_AMT1,JAO_NO2,JAS_NM2,JAA_AMT2,JAB_AMT2,JAC_AMT2,JAD_AMT2,JAE_AMT2,JAF_AMT2,JAG_AMT2,JAH_AMT2,JAJ_AMT2,JAK_AMT2,JAL_AMT2,JAN_AMT2,JAM_AMT2,JAP_AMT2,JAQ_AMT2,SEQ_NO2,JAI_AMT2,JAO_NO3,JAS_NM3,JAA_AMT3,JAB_AMT3,JAC_AMT3,JAD_AMT3,JAE_AMT3,JAF_AMT3,JAG_AMT3,JAH_AMT3,JAJ_AMT3,JAK_AMT3,JAL_AMT3,JAN_AMT3,JAM_AMT3,JAP_AMT3,JAQ_AMT3,SEQ_NO3,JAI_AMT3,ANNBO_AMT,ADDRESS_HOME,CET_NO,SDATE,EDATE,SALT_AMT2,TOT_AMT,COMP_NM,PRESIDENT_NM,TAX_NO,CORP_NO,ADDRESS,TEL_NO,TAX_OFFICE,CHI_CNT,SUM,SUM_PAY_AMTS,SUM_PAY_AMTB,SUM_JAI_AMT,TYPE,CET_NO2,STR,END,INP_CNT,INP_AMT,STOCK_DED,SAVE_DED,SAVE1_DED,SAVE2_DED,SAVE3_DED,SAVE4_DED,LOAN_DED,PLOAN_DED,MRENT_DED,LONG_DED,HOL_YN,RET_AMT,RET_DED,SUM_HINU,SUM_HINS";
    //String 	colStr  =   "PIS_YY,ENO_NO,PIS_MM,OCC_CD,GBN_TAG,MDPT_CD,MJOB_CD,MHOB_CD,SOU_CNT,DFM_CNT,TRB_CNT,GOL_CNT,WCT_CNT,RCH_CNT,MHS_TAG,LIN_AMT,LMA_AMT,LF2_AMT,LED_AMT,LEF_AMT,LF1_AMT,LC3_AMT,LC2_AMT,LC1_AMT,LHO_AMT,LH1_AMT,LJH_AMT,LST_AMT,LJJ_AMT,LSQ_AMT,CLS_TAG,DOMW_DD,OUTW_DD,OTHW_CNT,TOTW_DD,DOMT_AMTS,OUTT_AMTS,DOMT_AMTB,OUTT_AMTB,SALT_AMTS,SALT_AMTB,SALT_AMTT,PAYD_AMTS,PAYO_AMTS,PAYD_AMTB,PAYO_AMTB,TAX_INCOME,YAB_INCOME,FREE_INCOME,SIM_TAX,ITXD_AMT,STAX_DED,INCM_TAX,CITI_TAX,SAV_SJH,HINU_AMT,NPEN_AMT,HINS_AMT,APP_AMT,MGR_AMT,MNI_AMT,BADD_AMT,SPSB_AMT,GDED_AMT,GOL_AMT,TBL_DED,WDD_AMT,MHS_AMT,RCH_AMT,SMD_AMT,PER_TOT,MIN_DED,MMA_DED,EDU_DED,HOS_DED,CPC_DED,NSE_TOT,PER_SAV,INDED_TOT,TTAX_STD,TAX_AMT,HGR_DED,STX_DED,HTX_DED,HSX_DED,OTX_DED,TAX_DED,TDED_TOT,DGG_TAX,DJM_TAX,DBW_TAX,AGG_TAX,AJM_TAX,DRE_INTX,DRE_CTTX,DRE_DFTX,DRE_LSN,FIN_SALT,RPT_YM,CARD_DED,CARD_AMT,LIN_DED,FLD_AMT,FLD_DED,VEN_AMT,VEN_DED,SPC_TOT,CONT_TAX,LH2_AMT,LIH_AMT,CHI_AMT,HIG_AMT,UNI_AMT,GRA_AMT,ANN_AMT,GOV_AMT,LON_AMT,LIH_DED,LSX_DED,GOV_DED,NPEN_DED,ANN_DED,HAN_AMT,AGE_AMT,STA_TOT,LON2_AMT,VEN2_AMT,LEN_AMT,HED_AMT,DIR_AMT,MHEA_AMT,OHEA_AMT,LEN_AMT2,LEN_AMT3,LEN_AMT4,LEN_AMT5,EDU_TAG1,EDU_AMT1,EDU_TAG2,EDU_AMT2,EDU_TAG3,EDU_AMT3,EDU_TAG4,EDU_AMT4,EDU_TAG5,EDU_AMT5,WED_CNT,MOV_CNT,FUN_CNT,GOL_CNT70,GOL_CNT65,GOV_AMT04,LH2_AMT04,GOL_AMT70,GOL_AMT65,CHI_DED,HIG_DED,UNI_DED,WFM_DED,LH3_AMT,SEA_FREE,CASH_AMT,GIRO_AMT,LC3_NTS,GOV_NTS,LC1_NTS,LC2_NTS,IPT_MAN,IPT_YMD,UPT_MAN,UPT_YMD,TAX_DPT,JAS_NM,JAA_AMT,JAB_AMT,JAC_AMT,JAD_AMT,JAE_AMT,JAF_AMT,JAG_AMT,JAH_AMT,JAJ_AMT,JAK_AMT,JAL_AMT,JAN_AMT,JAM_AMT,JAP_AMT,JAQ_AMT,SEQ_NO,JAI_AMT,NRCH_CNT,ANNBO_AMT";
   	String[] values = colStr.split(",");
   	for( int x = 0; x < values.length; x++ ){
   		hnwExtQuery.AddField(values[x]);
   	}

       hnwExtQuery.SendField(response);

       if (voList.size() > 0)
       {
           for (int i=0; i<voList.size(); i++)
           {
               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

           	for( int x = 0; x < values.length; x++ ){
                   hnwExtQuery.AddData(vo.getString(values[x]));
           	}
               hnwExtQuery.SendData(response);
           }
       }
       else
       {
       	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
           hnwExtQuery.SendData(response);

       }

%>
