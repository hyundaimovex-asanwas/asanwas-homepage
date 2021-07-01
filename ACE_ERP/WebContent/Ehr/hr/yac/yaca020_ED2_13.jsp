<!--
***********************************************************************
* @source      : yaca020_ED2.jsp
* @description : 소득공제신고서
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2013/01/08      이동훈        최초작성.
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

    String sql = XmlSqlUtils.getSQL("yac", "YACA020_PRT_2013_02");
    
    //param binding 하기
    Object[] bind = new Object[] {		
    		ENO_NO,
    		PIS_YYMM,
    		ENO_NO,
    	  };

    AbstractDAO aaa= new AbstractDAO("default");
    
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
 
   	String 	colStr  =   "PIS_YY,ENO_NO,JAQ_AMT,JAR_AMT,JAH_AMT,JAP_AMT,NPEN_AMT,AR_AMT,PEN_SUM_AMT,HEALTH_AMT,HINS_AMT,LIN_AMT,LIH_AMT,INS_SUM_AMT,MHEA_AMT,LF2_AMT,OHEA_AMT,HEA_SUM_AMT,GRA_AMT,TAG1_CNT,EDU_AMT1,TAG2_CNT,EDU_AMT2,TAG3_CNT,EDU_AMT3,TAG4_CNT,EDU_AMT4,HED_AMT,EDU_SUM_AMT,LH1_AMT,LH2_AMT,LH2_AMT04,LH3_AMT,LH4_AMT,LH5_AMT,LH6_AMT,LH7_AMT,LH8_AMT,LH_SUM_AMT,GOV_AMT,LC3_AMT,LC2_AMT,LC4_AMT,LC_SUM_AMT";   
	
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
