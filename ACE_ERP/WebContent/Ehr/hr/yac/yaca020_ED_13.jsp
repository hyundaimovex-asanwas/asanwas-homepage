<!--
***********************************************************************
* @source      : yaca020_ED.jsp
* @description : 소득공제신고서
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
String ENO_NO = request.getParameter("ENO_NO");
String PIS_YYMM = request.getParameter("PIS_YYMM");
if (PIS_YYMM.length() > 4)
{
	PIS_YYMM = PIS_YYMM.substring(0,4);
}

    //String sql = XmlSqlUtils.getSQL("tax2", "TAXB040_PRT_01");
    
    //String sql = XmlSqlUtils.getSQL("tax2", "TAXB040_PRT_2012");
    
    String sql = XmlSqlUtils.getSQL("yac", "YACA020_PRT_2013");
    //param binding 하기
    Object[] bind = new Object[] {
    		ENO_NO,     
    		PIS_YYMM,    		
    		ENO_NO,      		
    		PIS_YYMM,    		
    		ENO_NO,
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	//String 	colStr  =   "PIS_YY,ENO_NM,CET_NO,ENO_NO,PIS_MM,OCC_CD,GBN_TAG,MDPT_CD,MJOB_CD,MHOB_CD,SOU_CNT,DFM_CNT,TRB_CNT,GOL_CNT,WCT_CNT,RCH_CNT,MHS_TAG,LIN_AMT,LMA_AMT,LF2_AMT,LED_AMT,LEF_AMT,LF1_AMT,LC4_AMT,LC3_AMT,LC2_AMT,LC1_AMT,LHO_AMT,LHP_AMT,LHQ_AMT,LHR_AMT,LH1_AMT,LH5_AMT,LH6_AMT,LJH_AMT,LST_AMT,LJJ_AMT,LSQ_AMT,CLS_TAG,DOMW_DD,OUTW_DD,OTHW_CNT,TOTW_DD,DOMT_AMTS,OUTT_AMTS,DOMT_AMTB,OUTT_AMTB,SALT_AMTS,SALT_AMTB,SALT_AMTT,PAYD_AMTS,PAYO_AMTS,PAYD_AMTB,PAYO_AMTB,TAX_INCOME,YAB_INCOME,FREE_INCOME,SIM_TAX,ITXD_AMT,STAX_DED,INCM_TAX,CITI_TAX,SAV_SJH,APP_AMT,MGR_AMT,MNI_AMT,BADD_AMT,SPSB_AMT,GDED_AMT,GOL_AMT,TBL_DED,WDD_AMT,MHS_AMT,RCH_AMT,SMD_AMT,PER_TOT,MIN_DED,MMA_DED,EDU_DED,HOS_DED,CPC_DED,NSE_TOT,PER_SAV,INDED_TOT,TTAX_STD,TAX_AMT,HGR_DED,STX_DED,HTX_DED,HSX_DED,OTX_DED,TAX_DED,TDED_TOT,DGG_TAX,DJM_TAX,DBW_TAX,AGG_TAX,AJM_TAX,DRE_INTX,DRE_CTTX,DRE_DFTX,DRE_LSN,FIN_SALT,RPT_YM,CARD_DED,CARD_AMT,LIN_DED,FLD_AMT,FLD_DED,VEN_AMT,VEN_DED,SPC_TOT,CONT_TAX,LH2_AMT,LIH_AMT,CHI_AMT,HIG_AMT,UNI_AMT,GRA_AMT,HED_AMT,ANN_AMT,GOV_AMT,LON_AMT,LIH_DED,LSX_DED,GOV_DED,NPEN_DED,ANN_DED,HAN_AMT,AGE_AMT,STA_TOT,LON2_AMT,VEN2_AMT,LEN_AMT,DIR_AMT,MHEA_AMT,OHEA_AMT,LEN_AMT2,LEN_AMT3,LEN_AMT4,LEN_AMT5,EDU_TAG1,EDU_AMT1,EDU_TAG2,EDU_AMT2,EDU_TAG3,EDU_AMT3,EDU_TAG4,EDU_AMT4,EDU_TAG5,EDU_AMT5,WED_CNT,MOV_CNT,FUN_CNT,GOL_CNT70,GOL_CNT65,GOV_AMT04,LH2_AMT04,GOL_AMT70,GOL_AMT65,CHI_DED,HIG_DED,UNI_DED,WFM_DED,LH3_AMT,SEA_FREE,CASH_AMT,GIRO_AMT,LC3_NTS,GOV_NTS,LC1_NTS,LC2_NTS,CARD_WRK_AMT,CARD_MED_AMT,CARD_NBMED_AMT,CASH_MED_AMT,TAX_DPT,JAS_NM,JAO_NO,JAA_AMT,JAB_AMT,JAC_AMT,JAD_AMT,JAE_AMT,JAF_AMT,JAG_AMT,JAH_AMT,JAJ_AMT,JAK_AMT,JAL_AMT,JAN_AMT,JAM_AMT,JAP_AMT,JAQ_AMT,JAR_AMT,SEQ_NO,JAI_AMT,EDU_AMT1,TAG1_CNT,EDU_AMT2,TAG2_CNT,EDU_AMT3,TAG3_CNT,EDU_AMT4,TAG4_CNT,GIBUGO,GOV_AMT2,GOV_AMT3,STOCK_AMT1,STOCK_AMT2,STOCK_AMT3,WEL_CARD,BFR_70YEAR,BFR_6YEAR,LH4_AMT,DIR_CARD_AMT,DIR_CARD_WRK_AMT,HOL_YN";

    
   	String 	colStr  =   "PIS_YY,ENO_NO,ENO_NM,CET_NO,WORKDAY,HOL_YN,CLS_TAG,CHILD,LIN_AMT_NTS,LIN_AMT,MED_AMT_NTS,MED_AMT,EDU_AMT_NTS,EDU_AMT,CARD_AMT_NTS,CARD_AMT,DIR_CARD_AMT_NTS,DIR_CARD_AMT,CASH_AMT_NTS,CASH_AMT,MARKET_AMT_NTS,MARKET_AMT,PUBLIC_AMT_NTS,PUBLIC_AMT,GIBU_AMT_NTS,GIBU_AMT";   
	
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
