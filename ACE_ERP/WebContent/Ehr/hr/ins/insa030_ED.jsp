<!--
***********************************************************************
* @source      : insa030_ED.jsp
* @description : 국민연금 개인별 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/07      김학수        최초작성.        
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
    String eno_no = request.getParameter("eno_no");
    String str_yy = request.getParameter("str_yy");
    String end_yy = request.getParameter("end_yy");

    StringBuffer sb  = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ins", "INSA030_SHR02");
    
    /** 조회 조건에 따른 처리 **/
    if (!str_yy.equals("") && !end_yy.equals("")) {
        sb.append("AND     PIS_YY >= '"+str_yy+"' \n");
        sb.append("                     AND     PIS_YY <= '"+end_yy+"'");
    } else if (!str_yy.equals("") && end_yy.equals("")) {
        sb.append("AND     PIS_YY >= '"+str_yy+"'");
    } else if (str_yy.equals("") && !end_yy.equals("")) {
        sb.append("AND     PIS_YY <= '"+end_yy+"'");
    }
    
    if( ! end_yy.equals("") ){ 
        sb2.append("WHERE   ENO_NO = '"+eno_no+"'");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb.toString(),
        sb2.toString()
    };
    
    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {};
		
    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("월");
    hnwExtQuery.AddField("등급");
    hnwExtQuery.AddField("표준보수월액");
    hnwExtQuery.AddField("본인부담금");
    hnwExtQuery.AddField("회사부담금");
    hnwExtQuery.AddField("합계");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int cnt = 0;
    int monCnt = 0;
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size()-1; i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            if ( end_yy.equals(vo.getString("PIS_YY")) ) {
                cnt = cnt + 1;
            }
            
            if(vo.getString("PIS_MM").equals("소계")){
           		for(int j=monCnt; j<12; j++){
           			hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
             
                    hnwExtQuery.SendData(response); 
           		}

            }else{
            	monCnt = monCnt + 1;
            }
            
            hnwExtQuery.AddData(vo.getString("PIS_MM"));
            hnwExtQuery.AddData(vo.getString("NPN_GRD"));
            hnwExtQuery.AddData(vo.getString("STDB_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("COM_AMT"));
            hnwExtQuery.AddData(vo.getString("NPN_SUM"));
  
            hnwExtQuery.SendData(response);
            //System.out.println("-->"+vo.getString("PIS_YY")+",    "+vo.getString("PIS_MM"));
        }
        for ( int i=0; i<12-cnt; i++ )        //마지막달의 공백처리(총계가 다음페이지에 나와야함)
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
  
            hnwExtQuery.SendData(response); 
        }

        DynamicValueObject vo = (DynamicValueObject)voList.get(voList.size()-1);   //총계

        hnwExtQuery.AddData(vo.getString("PIS_MM"));
        hnwExtQuery.AddData(vo.getString("NPN_GRD"));
        hnwExtQuery.AddData(vo.getString("STDB_AMT"));
        hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
        hnwExtQuery.AddData(vo.getString("COM_AMT"));
        hnwExtQuery.AddData(vo.getString("NPN_SUM"));

        hnwExtQuery.SendData(response);    
    }

%>