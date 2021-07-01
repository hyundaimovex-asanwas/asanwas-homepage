<!--
***********************************************************************
* @source      : pirh010_ED.jsp
* @description : 학력별인원현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
	String BIR_YMD_SHR	= request.getParameter("BIR_YMD_SHR").replaceAll("-", "");
	String OCC_CD_SHR    	= request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR		= request.getParameter("GBN_CD_SHR");
	String FLAG_SHR		= request.getParameter("FLAG_SHR");
	String AGE_SHR		= request.getParameter("AGE_SHR");

	/////////////////////////////System.out.println(FLAG_SHR);
	if(FLAG_SHR.equals("JOB")){       //////////////////////////////////////////////////// 직위별
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {};

		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( ! GBN_CD_SHR.equals("0") ){
			if( GBN_CD_SHR.equals("1") ){
				sb.append("AND GBN_CD  = '1' \n"); // 본사 만
			}else{
				sb.append("AND GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
			}
		}
		if( ! OCC_CD_SHR.equals("0") ){
			sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
		}

		// 20|21|26|31|36|41|46|51|56|61  으로 전달됨
		String[] arrCon = AGE_SHR.split(",");
	  	//System.out.println(AGE_SHR);
	  	//System.out.println(arrCon.length-2);
		String sql = "";
		sql += "SELECT  RN  \n";
		sql += "       ,JOB_NM  \n";
		sql += "       ,DECODE(AGE_TOT, NULL, '', AGE_TOT || '명') as age_tot_cnt  , (ROUND( (AGE_TOT/(MAX(AGE_TOT) OVER (PARTITION BY 2) )* 100),1)||'%') AS AGE_TOT_per   \n";
		sql += "       ,FLOOR((AGE_MON/AGE_TOT)/12) ||'.'|| FLOOR(MOD(AGE_MON/AGE_TOT,12)) AS AGE_AVG   \n";
		sql += "       ,DECODE(AGE_01, NULL, '', AGE_01 || '명') AGE_01_CNT, DECODE(AGE_01, NULL, '', ROUND( (AGE_01/AGE_TOT)*100,1)||'%')  AS AGE_01_PER  \n";
		sql += "        ,DECODE(AGE_02, NULL, '', AGE_02 || '명') AGE_02_CNT, DECODE(AGE_02, NULL, '', ROUND( (AGE_02/AGE_TOT)*100,1)||'%')  AS AGE_02_PER \n";

		String[] arrSel_01 = new String[]{
				"    ,DECODE(AGE_03, NULL, '', AGE_03 || '명') AGE_03_CNT, DECODE(AGE_03, NULL, '', ROUND( (AGE_03/AGE_TOT)*100,1)||'%')  AS AGE_03_PER \n",
				"    ,DECODE(AGE_04, NULL, '', AGE_04 || '명') AGE_04_CNT, DECODE(AGE_04, NULL, '', ROUND( (AGE_04/AGE_TOT)*100,1)||'%')  AS AGE_04_PER \n",
				"    ,DECODE(AGE_05, NULL, '', AGE_05 || '명') AGE_05_CNT, DECODE(AGE_05, NULL, '', ROUND( (AGE_05/AGE_TOT)*100,1)||'%')  AS AGE_05_PER \n",
				"    ,DECODE(AGE_06, NULL, '', AGE_06 || '명') AGE_06_CNT, DECODE(AGE_06, NULL, '', ROUND( (AGE_06/AGE_TOT)*100,1)||'%')  AS AGE_06_PER \n",
				"    ,DECODE(AGE_07, NULL, '', AGE_07 || '명') AGE_07_CNT, DECODE(AGE_07, NULL, '', ROUND( (AGE_07/AGE_TOT)*100,1)||'%')  AS AGE_07_PER \n",
				"    ,DECODE(AGE_08, NULL, '', AGE_08 || '명') AGE_08_CNT, DECODE(AGE_08, NULL, '', ROUND( (AGE_08/AGE_TOT)*100,1)||'%')  AS AGE_08_PER \n",
				"    ,DECODE(AGE_09, NULL, '', AGE_09 || '명') AGE_09_CNT, DECODE(AGE_09, NULL, '', ROUND( (AGE_09/AGE_TOT)*100,1)||'%')  AS AGE_09_PER \n",
				"    ,DECODE(AGE_10, NULL, '', AGE_10 || '명') AGE_10_CNT, DECODE(AGE_10, NULL, '', ROUND( (AGE_10/AGE_TOT)*100,1)||'%')  AS AGE_10_PER \n"
		};

		for(int a=0; a<arrCon.length-2; a++){
			//System.out.println(arrSel_01[a]);
				sql += arrSel_01[a];
		}

		sql += "FROM (  \n";
		sql += "      SELECT  DECODE(L.NO, 1, ROW_NUMBER() OVER(ORDER BY L.NO), '') RN  \n";
		sql += "             ,DECODE(L.NO, 1, K.JOB_NM, '합계') JOB_NM  \n";
		sql += "             ,DECODE(L.NO, 1, K.JOB_SEQ, DECODE(L.NO, 1, '0', '999')) AS JOB_SEQ  \n";
		sql += "             ,DECODE(L.NO, 1, SUM(K.AGE_MON), SUM(K.AGE_MON) ) AS AGE_MON  \n";
		sql += "             ,SUM(K.AGE_TOT) AS AGE_TOT  \n";
		sql += "             ,SUM(K.AGE_01)  AS AGE_01  \n";
		sql += "             ,SUM(K.AGE_02)  AS AGE_02  \n";

		String[] arrSel_02 = new String[]{
			   "             ,SUM(K.AGE_03)  AS AGE_03 \n",
			   "             ,SUM(K.AGE_04)  AS AGE_04 \n",
			   "             ,SUM(K.AGE_05)  AS AGE_05 \n",
			   "             ,SUM(K.AGE_06)  AS AGE_06 \n",
			   "             ,SUM(K.AGE_07)  AS AGE_07 \n",
			   "             ,SUM(K.AGE_08)  AS AGE_08 \n",
			   "             ,SUM(K.AGE_09)  AS AGE_09 \n",
			   "             ,SUM(K.AGE_10)  AS AGE_10 \n"
		};

		for(int b=0; b<arrCon.length-2; b++){
			sql += arrSel_02[b];
		}

		sql += "      FROM ( \n";
		sql += "            SELECT A.JOB_NM, A.AGE_TOT \n";
		sql += "                  ,DECODE(A.JOB_NM, '기타', '999', JOB_SEQ) AS JOB_SEQ \n";
		sql += "                  ,( DECODE(T01.AGE_MON,NULL,0,T01.AGE_MON) \n";
		sql += "                   + DECODE(T02.AGE_MON,NULL,0,T02.AGE_MON) \n";
		String[] arrSel_03 = new String[]{
				"                   + DECODE(T03.AGE_MON,NULL,0,T03.AGE_MON) \n",
				"                   + DECODE(T04.AGE_MON,NULL,0,T04.AGE_MON) \n",
				"                   + DECODE(T05.AGE_MON,NULL,0,T05.AGE_MON) \n",
				"                   + DECODE(T06.AGE_MON,NULL,0,T06.AGE_MON) \n",
				"                   + DECODE(T07.AGE_MON,NULL,0,T07.AGE_MON) \n",
				"                   + DECODE(T08.AGE_MON,NULL,0,T08.AGE_MON) \n",
				"                   + DECODE(T09.AGE_MON,NULL,0,T09.AGE_MON) \n",
				"                   + DECODE(T10.AGE_MON,NULL,0,T10.AGE_MON) \n",
		};
		for(int c=0; c<arrCon.length-2; c++){
			sql += arrSel_03[c];
		}
		sql += "                    ) AS AGE_MON  \n";
		sql += "                  ,T01.AGE_01  \n";
		sql += "                  ,T02.AGE_02  \n";

		String[] arrSel_04 = new String[]{
			   "                  ,T03.AGE_03 \n",
			   "                  ,T04.AGE_04 \n",
			   "                  ,T05.AGE_05 \n",
			   "                  ,T06.AGE_06 \n",
			   "                  ,T07.AGE_07 \n",
			   "                  ,T08.AGE_08 \n",
			   "                  ,T09.AGE_09 \n",
			   "                  ,T10.AGE_10 \n",
		};
		for(int j=0; j<arrCon.length-2; j++){
			sql += arrSel_04[j];
		}

		sql += "            FROM  ( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, MAX(JOB_SEQ) AS JOB_SEQ, COUNT(*) AS AGE_TOT  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  1=1  \n";
		sql += "                    [1]  \n";
		sql += "                    GROUP BY JOB_NM  \n";
		sql += "                   ) A  \n";
		sql += "                 ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AGE_01  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) <= "+arrCon[0]+"  \n";
		sql += "                    [2]  \n";
		sql += "                    GROUP BY JOB_NM  \n";
		sql += "                   ) T01  \n";
		sql += "                 ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_02  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[1]+"  \n";
		if(arrCon[2] != ""){
			sql += "                AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[2]+"  \n";
		}
		sql += "                    [3]  \n";
		sql += "                    GROUP BY JOB_NM  \n";
		sql += "                   ) T02  \n";

//		 조회할 인라인 뷰
		String T03 = "";
		T03 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_03  \n";
		T03 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T03 += "               FROM   VI_T_CM_PERSON  \n";
		T03 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[2]+"  \n";
		if(arrCon[3] != ""){
			T03 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[3]+"  \n";
		}
		T03 += "               [4]  \n";
		T03 += "               GROUP BY JOB_NM  \n";
		T03 += "               ) T03  \n";

		String T04 = "";
		T04 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_04  \n";
		T04 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T04 += "               FROM   VI_T_CM_PERSON  \n";
		T04 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[3]+"  \n";
		if(arrCon[4] != ""){
			T04 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[4]+"  \n";
		}
		T04 += "               [5]  \n";
		T04 += "               GROUP BY JOB_NM  \n";
		T04 += "               ) T04  \n";

		String T05 = "";
		T05 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_05  \n";
		T05 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T05 += "               FROM   VI_T_CM_PERSON  \n";
		T05 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[4]+"  \n";
		if(arrCon[5] != ""){
			T05 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[5]+"  \n";
		}
		T05 += "               [6]  \n";
		T05 += "               GROUP BY JOB_NM  \n";
		T05 += "               ) T05  \n";


		String T06 = "";
		T06 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_06  \n";
		T06 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T06 += "               FROM   VI_T_CM_PERSON  \n";
		T06 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[5]+"  \n";
		if(arrCon[6] != ""){
			T06 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[6]+"  \n";
		}
		T06 += "               [7]  \n";
		T06 += "               GROUP BY JOB_NM  \n";
		T06 += "               ) T06  \n";

		String T07 = "";
		T07 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_07  \n";
		T07 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T07 += "               FROM   VI_T_CM_PERSON  \n";
		T07 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[6]+"  \n";
		if(arrCon[7] != ""){
			T07 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[7]+"  \n";
		}
		T07 += "               [8]  \n";
		T07 += "               GROUP BY JOB_NM  \n";
		T07 += "               ) T07  \n";

		String T08 = "";
		T08 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_08  \n";
		T08 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T08 += "               FROM   VI_T_CM_PERSON  \n";
		T08 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[7]+"  \n";
		if(arrCon[8] != ""){
			T08 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[8]+"  \n";
		}
		T08 += "               [9]  \n";
		T08 += "               GROUP BY JOB_NM  \n";
		T08 += "               ) T08  \n";

		String T09 = "";
		T09 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_09  \n";
		T09 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T09 += "               FROM   VI_T_CM_PERSON  \n";
		T09 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[8]+"  \n";
		if(arrCon[9] != ""){
			T09 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[9]+"  \n";
		}
		T09 += "               [10]  \n";
		T09 += "               GROUP BY JOB_NM  \n";
		T09 += "               ) T09  \n";

		String T10 = "";
		T10 += "            ,( SELECT DECODE(JOB_NM, NULL, '기타', JOB_NM) AS JOB_NM, COUNT(*) AS AGE_10  \n";
		T10 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T10 += "               FROM   VI_T_CM_PERSON  \n";
		T10 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[9]+"  \n";
		T10 += "               [11]  \n";
		T10 += "               GROUP BY JOB_NM  \n";
		T10 += "               ) T10  \n";


		String[] arrTbl = new String[]{
				T03,
				T04,
				T05,
				T06,
				T07,
				T08,
				T09,
				T10,
		};
		for(int k=0; k<arrCon.length-2; k++){
			sql += arrTbl[k];
		}

		sql += "            WHERE  A.JOB_NM = T01.JOB_NM(+)  \n";
		sql += "            AND    A.JOB_NM = T02.JOB_NM(+)  \n";

		String[] arrJoin = new String[]{
			   "            AND    A.JOB_NM = T03.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T04.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T05.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T06.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T07.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T08.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T09.JOB_NM(+)  \n",
			   "            AND    A.JOB_NM = T10.JOB_NM(+)  \n",
		};
		for(int l=0; l<arrCon.length-2; l++){
			sql += arrJoin[l];
		}

		sql += "            ORDER  BY JOB_SEQ, JOB_NM  \n";
		sql += "           ) K,  \n";
		sql += "          ( SELECT 1 AS NO FROM DUAL UNION ALL  \n";
		sql += "            SELECT 2 AS NO FROM DUAL   \n";
		sql += "           ) L    \n";
		sql += "      GROUP BY L.NO, DECODE(L.NO, 1, K.JOB_SEQ, DECODE(L.NO, 1, '0', '999')), DECODE(L.NO, 1, K.JOB_NM, '합계')  \n";
		sql += "     ) I  \n";
		sql += "  ORDER BY TO_NUMBER(I.JOB_SEQ)   \n";

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	    extquery hnwExtQuery = new extquery();


		/** 필드값 세팅 **/
		String 	colStr  =   "RN,JOB_NM,AGE_TOT_CNT,AGE_TOT_PER,AGE_AVG,AGE_01_CNT,AGE_01_PER,AGE_02_CNT,AGE_02_PER,AGE_03_CNT,AGE_03_PER,AGE_04_CNT,AGE_04_PER,AGE_05_CNT,AGE_05_PER,AGE_06_CNT,AGE_06_PER,AGE_07_CNT,AGE_07_PER,AGE_08_CNT,AGE_08_PER,AGE_09_CNT,AGE_09_PER,AGE_10_CNT,AGE_10_PER";
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

	}else if(FLAG_SHR.equals("BCT")){ ///////////////////////////////////////////////////////////// 출신도별
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {};

		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( ! GBN_CD_SHR.equals("0") ){
			if( GBN_CD_SHR.equals("1") ){
				sb.append("AND GBN_CD  = '1' \n"); // 본사 만
			}else{
				sb.append("AND GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
			}
		}
		if( ! OCC_CD_SHR.equals("0") ){
			sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
		}

		// 20|21|26|31|36|41|46|51|56|61  으로 전달됨
		String[] arrCon = AGE_SHR.split(",");
	  	//System.out.println(AGE_SHR);
	  	//System.out.println(arrCon.length-2);
		String sql = "";
		sql += "SELECT  RN  \n";
		sql += "       ,BCT_NM AS JOB_NM  \n";
		sql += "       ,DECODE(AGE_TOT, NULL, '', AGE_TOT || '명') as age_tot_cnt  , (ROUND( (AGE_TOT/(MAX(AGE_TOT) OVER (PARTITION BY 2) )* 100),1)||'%') AS AGE_TOT_per   \n";
		sql += "       ,FLOOR((AGE_MON/AGE_TOT)/12) ||'.'|| FLOOR(MOD(AGE_MON/AGE_TOT,12)) AS AGE_AVG   \n";
		sql += "       ,DECODE(AGE_01, NULL, '', AGE_01 || '명') AGE_01_CNT, DECODE(AGE_01, NULL, '', ROUND( (AGE_01/AGE_TOT)*100,1)||'%')  AS AGE_01_PER  \n";
		sql += "        ,DECODE(AGE_02, NULL, '', AGE_02 || '명') AGE_02_CNT, DECODE(AGE_02, NULL, '', ROUND( (AGE_02/AGE_TOT)*100,1)||'%')  AS AGE_02_PER \n";

		String[] arrSel_01 = new String[]{
				"    ,DECODE(AGE_03, NULL, '', AGE_03 || '명') AGE_03_CNT, DECODE(AGE_03, NULL, '', ROUND( (AGE_03/AGE_TOT)*100,1)||'%')  AS AGE_03_PER \n",
				"    ,DECODE(AGE_04, NULL, '', AGE_04 || '명') AGE_04_CNT, DECODE(AGE_04, NULL, '', ROUND( (AGE_04/AGE_TOT)*100,1)||'%')  AS AGE_04_PER \n",
				"    ,DECODE(AGE_05, NULL, '', AGE_05 || '명') AGE_05_CNT, DECODE(AGE_05, NULL, '', ROUND( (AGE_05/AGE_TOT)*100,1)||'%')  AS AGE_05_PER \n",
				"    ,DECODE(AGE_06, NULL, '', AGE_06 || '명') AGE_06_CNT, DECODE(AGE_06, NULL, '', ROUND( (AGE_06/AGE_TOT)*100,1)||'%')  AS AGE_06_PER \n",
				"    ,DECODE(AGE_07, NULL, '', AGE_07 || '명') AGE_07_CNT, DECODE(AGE_07, NULL, '', ROUND( (AGE_07/AGE_TOT)*100,1)||'%')  AS AGE_07_PER \n",
				"    ,DECODE(AGE_08, NULL, '', AGE_08 || '명') AGE_08_CNT, DECODE(AGE_08, NULL, '', ROUND( (AGE_08/AGE_TOT)*100,1)||'%')  AS AGE_08_PER \n",
				"    ,DECODE(AGE_09, NULL, '', AGE_09 || '명') AGE_09_CNT, DECODE(AGE_09, NULL, '', ROUND( (AGE_09/AGE_TOT)*100,1)||'%')  AS AGE_09_PER \n",
				"    ,DECODE(AGE_10, NULL, '', AGE_10 || '명') AGE_10_CNT, DECODE(AGE_10, NULL, '', ROUND( (AGE_10/AGE_TOT)*100,1)||'%')  AS AGE_10_PER \n"
		};

		for(int a=0; a<arrCon.length-2; a++){
			//System.out.println(arrSel_01[a]);
				sql += arrSel_01[a];
		}

		sql += "FROM (  \n";
		sql += "      SELECT  DECODE(L.NO, 1, ROW_NUMBER() OVER(ORDER BY L.NO), '') RN  \n";
		sql += "             ,DECODE(L.NO, 1, K.BCT_NM, '합계') BCT_NM  \n";
		sql += "             ,DECODE(L.NO, 1, K.BCT_SEQ, DECODE(L.NO, 1, '0', '999')) AS BCT_SEQ  \n";
		sql += "             ,DECODE(L.NO, 1, SUM(K.AGE_MON), SUM(K.AGE_MON) ) AS AGE_MON  \n";
		sql += "             ,SUM(K.AGE_TOT) AS AGE_TOT  \n";
		sql += "             ,SUM(K.AGE_01)  AS AGE_01  \n";
		sql += "             ,SUM(K.AGE_02)  AS AGE_02  \n";

		String[] arrSel_02 = new String[]{
			   "             ,SUM(K.AGE_03)  AS AGE_03 \n",
			   "             ,SUM(K.AGE_04)  AS AGE_04 \n",
			   "             ,SUM(K.AGE_05)  AS AGE_05 \n",
			   "             ,SUM(K.AGE_06)  AS AGE_06 \n",
			   "             ,SUM(K.AGE_07)  AS AGE_07 \n",
			   "             ,SUM(K.AGE_08)  AS AGE_08 \n",
			   "             ,SUM(K.AGE_09)  AS AGE_09 \n",
			   "             ,SUM(K.AGE_10)  AS AGE_10 \n"
		};

		for(int b=0; b<arrCon.length-2; b++){
			sql += arrSel_02[b];
		}

		sql += "      FROM ( \n";
		sql += "            SELECT A.BCT_NM, A.AGE_TOT \n";
		sql += "                  ,DECODE(A.BCT_NM, '기타', '999', '0') AS BCT_SEQ \n";
		sql += "                  ,( DECODE(T01.AGE_MON,NULL,0,T01.AGE_MON) \n";
		sql += "                   + DECODE(T02.AGE_MON,NULL,0,T02.AGE_MON) \n";
		String[] arrSel_03 = new String[]{
				"                   + DECODE(T03.AGE_MON,NULL,0,T03.AGE_MON) \n",
				"                   + DECODE(T04.AGE_MON,NULL,0,T04.AGE_MON) \n",
				"                   + DECODE(T05.AGE_MON,NULL,0,T05.AGE_MON) \n",
				"                   + DECODE(T06.AGE_MON,NULL,0,T06.AGE_MON) \n",
				"                   + DECODE(T07.AGE_MON,NULL,0,T07.AGE_MON) \n",
				"                   + DECODE(T08.AGE_MON,NULL,0,T08.AGE_MON) \n",
				"                   + DECODE(T09.AGE_MON,NULL,0,T09.AGE_MON) \n",
				"                   + DECODE(T10.AGE_MON,NULL,0,T10.AGE_MON) \n",
		};
		for(int c=0; c<arrCon.length-2; c++){
			sql += arrSel_03[c];
		}
		sql += "                    ) AS AGE_MON  \n";
		sql += "                  ,T01.AGE_01  \n";
		sql += "                  ,T02.AGE_02  \n";

		String[] arrSel_04 = new String[]{
			   "                  ,T03.AGE_03 \n",
			   "                  ,T04.AGE_04 \n",
			   "                  ,T05.AGE_05 \n",
			   "                  ,T06.AGE_06 \n",
			   "                  ,T07.AGE_07 \n",
			   "                  ,T08.AGE_08 \n",
			   "                  ,T09.AGE_09 \n",
			   "                  ,T10.AGE_10 \n",
		};
		for(int j=0; j<arrCon.length-2; j++){
			sql += arrSel_04[j];
		}

		sql += "            FROM  ( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_TOT  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  1=1  \n";
		sql += "                    [1]  \n";
		sql += "                    GROUP BY BCT_CD  \n";
		sql += "                   ) A  \n";
		sql += "                 ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AGE_01  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) <= "+arrCon[0]+"  \n";
		sql += "                    [2]  \n";
		sql += "                    GROUP BY BCT_CD  \n";
		sql += "                   ) T01  \n";
		sql += "                 ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_02  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[1]+"  \n";
		if(arrCon[2] != ""){
			sql += "                AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[2]+"  \n";
		}
		sql += "                    [3]  \n";
		sql += "                    GROUP BY BCT_CD  \n";
		sql += "                   ) T02  \n";

//		 조회할 인라인 뷰
		String T03 = "";
		T03 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_03  \n";
		T03 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T03 += "               FROM   VI_T_CM_PERSON  \n";
		T03 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[2]+"  \n";
		if(arrCon[3] != ""){
			T03 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[3]+"  \n";
		}
		T03 += "               [4]  \n";
		T03 += "               GROUP BY BCT_CD  \n";
		T03 += "               ) T03  \n";

		String T04 = "";
		T04 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_04  \n";
		T04 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T04 += "               FROM   VI_T_CM_PERSON  \n";
		T04 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[3]+"  \n";
		if(arrCon[4] != ""){
			T04 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[4]+"  \n";
		}
		T04 += "               [5]  \n";
		T04 += "               GROUP BY BCT_CD  \n";
		T04 += "               ) T04  \n";

		String T05 = "";
		T05 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_05  \n";
		T05 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T05 += "               FROM   VI_T_CM_PERSON  \n";
		T05 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[4]+"  \n";
		if(arrCon[5] != ""){
			T05 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[5]+"  \n";
		}
		T05 += "               [6]  \n";
		T05 += "               GROUP BY BCT_CD  \n";
		T05 += "               ) T05  \n";


		String T06 = "";
		T06 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_06  \n";
		T06 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T06 += "               FROM   VI_T_CM_PERSON  \n";
		T06 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[5]+"  \n";
		if(arrCon[6] != ""){
			T06 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[6]+"  \n";
		}
		T06 += "               [7]  \n";
		T06 += "               GROUP BY BCT_CD  \n";
		T06 += "               ) T06  \n";

		String T07 = "";
		T07 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_07  \n";
		T07 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T07 += "               FROM   VI_T_CM_PERSON  \n";
		T07 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[6]+"  \n";
		if(arrCon[7] != ""){
			T07 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[7]+"  \n";
		}
		T07 += "               [8]  \n";
		T07 += "               GROUP BY BCT_CD  \n";
		T07 += "               ) T07  \n";

		String T08 = "";
		T08 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_08  \n";
		T08 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T08 += "               FROM   VI_T_CM_PERSON  \n";
		T08 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[7]+"  \n";
		if(arrCon[8] != ""){
			T08 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[8]+"  \n";
		}
		T08 += "               [9]  \n";
		T08 += "               GROUP BY BCT_CD  \n";
		T08 += "               ) T08  \n";

		String T09 = "";
		T09 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_09  \n";
		T09 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T09 += "               FROM   VI_T_CM_PERSON  \n";
		T09 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[8]+"  \n";
		if(arrCon[9] != ""){
			T09 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[9]+"  \n";
		}
		T09 += "               [10]  \n";
		T09 += "               GROUP BY BCT_CD  \n";
		T09 += "               ) T09  \n";

		String T10 = "";
		T10 += "            ,( SELECT DECODE(BCT_CD, NULL, '기타', SF_GET_COMMNAME('01' , 'B4', BCT_CD)) AS BCT_NM, COUNT(*) AS AGE_10  \n";
		T10 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T10 += "               FROM   VI_T_CM_PERSON  \n";
		T10 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[9]+"  \n";
		T10 += "               [11]  \n";
		T10 += "               GROUP BY BCT_CD  \n";
		T10 += "               ) T10  \n";


		String[] arrTbl = new String[]{
				T03,
				T04,
				T05,
				T06,
				T07,
				T08,
				T09,
				T10,
		};
		for(int k=0; k<arrCon.length-2; k++){
			sql += arrTbl[k];
		}

		sql += "            WHERE  A.BCT_NM = T01.BCT_NM(+)  \n";
		sql += "            AND    A.BCT_NM = T02.BCT_NM(+)  \n";

		String[] arrJoin = new String[]{
			   "            AND    A.BCT_NM = T03.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T04.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T05.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T06.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T07.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T08.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T09.BCT_NM(+)  \n",
			   "            AND    A.BCT_NM = T10.BCT_NM(+)  \n",
		};
		for(int l=0; l<arrCon.length-2; l++){
			sql += arrJoin[l];
		}

		sql += "            ORDER  BY BCT_SEQ, BCT_NM  \n";
		sql += "           ) K,  \n";
		sql += "          ( SELECT 1 AS NO FROM DUAL UNION ALL  \n";
		sql += "            SELECT 2 AS NO FROM DUAL   \n";
		sql += "           ) L    \n";
		sql += "      GROUP BY L.NO, DECODE(L.NO, 1, K.BCT_SEQ, DECODE(L.NO, 1, '0', '999')), DECODE(L.NO, 1, K.BCT_NM, '합계')  \n";
		sql += "     ) I  \n";
		sql += "  ORDER BY I.BCT_SEQ, I.BCT_NM   \n";

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	    extquery hnwExtQuery = new extquery();


		/** 필드값 세팅 **/
		String 	colStr  =   "RN,JOB_NM,AGE_TOT_CNT,AGE_TOT_PER,AGE_AVG,AGE_01_CNT,AGE_01_PER,AGE_02_CNT,AGE_02_PER,AGE_03_CNT,AGE_03_PER,AGE_04_CNT,AGE_04_PER,AGE_05_CNT,AGE_05_PER,AGE_06_CNT,AGE_06_PER,AGE_07_CNT,AGE_07_PER,AGE_08_CNT,AGE_08_PER,AGE_09_CNT,AGE_09_PER,AGE_10_CNT,AGE_10_PER";
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

	}else{ ///////////////////////////////////////////////////////////////////////////////////////// 거주지별
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {};

		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( ! GBN_CD_SHR.equals("0") ){
			if( GBN_CD_SHR.equals("1") ){
				sb.append("AND GBN_CD  = '1' \n"); // 본사 만
			}else{
				sb.append("AND GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
			}
		}
		if( ! OCC_CD_SHR.equals("0") ){
			sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
		}

		// 20|21|26|31|36|41|46|51|56|61  으로 전달됨
		String[] arrCon = AGE_SHR.split(",");
	  	//System.out.println(AGE_SHR);
	  	//System.out.println(arrCon.length-2);
		String sql = "";
		sql += "SELECT  RN  \n";
		sql += "       ,ADR_NM AS JOB_NM  \n";
		sql += "       ,DECODE(AGE_TOT, NULL, '', AGE_TOT || '명') as age_tot_cnt  , (ROUND( (AGE_TOT/(MAX(AGE_TOT) OVER (PARTITION BY 2) )* 100),1)||'%') AS AGE_TOT_per   \n";
		sql += "       ,FLOOR((AGE_MON/AGE_TOT)/12) ||'.'|| FLOOR(MOD(AGE_MON/AGE_TOT,12)) AS AGE_AVG   \n";
		sql += "       ,DECODE(AGE_01, NULL, '', AGE_01 || '명') AGE_01_CNT, DECODE(AGE_01, NULL, '', ROUND( (AGE_01/AGE_TOT)*100,1)||'%')  AS AGE_01_PER  \n";
		sql += "        ,DECODE(AGE_02, NULL, '', AGE_02 || '명') AGE_02_CNT, DECODE(AGE_02, NULL, '', ROUND( (AGE_02/AGE_TOT)*100,1)||'%')  AS AGE_02_PER \n";

		String[] arrSel_01 = new String[]{
				"    ,DECODE(AGE_03, NULL, '', AGE_03 || '명') AGE_03_CNT, DECODE(AGE_03, NULL, '', ROUND( (AGE_03/AGE_TOT)*100,1)||'%')  AS AGE_03_PER \n",
				"    ,DECODE(AGE_04, NULL, '', AGE_04 || '명') AGE_04_CNT, DECODE(AGE_04, NULL, '', ROUND( (AGE_04/AGE_TOT)*100,1)||'%')  AS AGE_04_PER \n",
				"    ,DECODE(AGE_05, NULL, '', AGE_05 || '명') AGE_05_CNT, DECODE(AGE_05, NULL, '', ROUND( (AGE_05/AGE_TOT)*100,1)||'%')  AS AGE_05_PER \n",
				"    ,DECODE(AGE_06, NULL, '', AGE_06 || '명') AGE_06_CNT, DECODE(AGE_06, NULL, '', ROUND( (AGE_06/AGE_TOT)*100,1)||'%')  AS AGE_06_PER \n",
				"    ,DECODE(AGE_07, NULL, '', AGE_07 || '명') AGE_07_CNT, DECODE(AGE_07, NULL, '', ROUND( (AGE_07/AGE_TOT)*100,1)||'%')  AS AGE_07_PER \n",
				"    ,DECODE(AGE_08, NULL, '', AGE_08 || '명') AGE_08_CNT, DECODE(AGE_08, NULL, '', ROUND( (AGE_08/AGE_TOT)*100,1)||'%')  AS AGE_08_PER \n",
				"    ,DECODE(AGE_09, NULL, '', AGE_09 || '명') AGE_09_CNT, DECODE(AGE_09, NULL, '', ROUND( (AGE_09/AGE_TOT)*100,1)||'%')  AS AGE_09_PER \n",
				"    ,DECODE(AGE_10, NULL, '', AGE_10 || '명') AGE_10_CNT, DECODE(AGE_10, NULL, '', ROUND( (AGE_10/AGE_TOT)*100,1)||'%')  AS AGE_10_PER \n"
		};

		for(int a=0; a<arrCon.length-2; a++){
			//System.out.println(arrSel_01[a]);
				sql += arrSel_01[a];
		}

		sql += "FROM (  \n";
		sql += "      SELECT  DECODE(L.NO, 1, ROW_NUMBER() OVER(ORDER BY L.NO), '') RN  \n";
		sql += "             ,DECODE(L.NO, 1, K.ADR_NM, '합계') ADR_NM  \n";
		sql += "             ,DECODE(L.NO, 1, K.ADR_SEQ, DECODE(L.NO, 1, '0', '999')) AS ADR_SEQ  \n";
		sql += "             ,DECODE(L.NO, 1, SUM(K.AGE_MON), SUM(K.AGE_MON) ) AS AGE_MON  \n";
		sql += "             ,SUM(K.AGE_TOT) AS AGE_TOT  \n";
		sql += "             ,SUM(K.AGE_01)  AS AGE_01  \n";
		sql += "             ,SUM(K.AGE_02)  AS AGE_02  \n";

		String[] arrSel_02 = new String[]{
			   "             ,SUM(K.AGE_03)  AS AGE_03 \n",
			   "             ,SUM(K.AGE_04)  AS AGE_04 \n",
			   "             ,SUM(K.AGE_05)  AS AGE_05 \n",
			   "             ,SUM(K.AGE_06)  AS AGE_06 \n",
			   "             ,SUM(K.AGE_07)  AS AGE_07 \n",
			   "             ,SUM(K.AGE_08)  AS AGE_08 \n",
			   "             ,SUM(K.AGE_09)  AS AGE_09 \n",
			   "             ,SUM(K.AGE_10)  AS AGE_10 \n"
		};

		for(int b=0; b<arrCon.length-2; b++){
			sql += arrSel_02[b];
		}

		sql += "      FROM ( \n";
		sql += "            SELECT A.ADR_NM, A.AGE_TOT \n";
		sql += "                  ,DECODE(A.ADR_NM, '기타', '999', '0') AS ADR_SEQ \n";
		sql += "                  ,( DECODE(T01.AGE_MON,NULL,0,T01.AGE_MON) \n";
		sql += "                   + DECODE(T02.AGE_MON,NULL,0,T02.AGE_MON) \n";
		String[] arrSel_03 = new String[]{
				"                   + DECODE(T03.AGE_MON,NULL,0,T03.AGE_MON) \n",
				"                   + DECODE(T04.AGE_MON,NULL,0,T04.AGE_MON) \n",
				"                   + DECODE(T05.AGE_MON,NULL,0,T05.AGE_MON) \n",
				"                   + DECODE(T06.AGE_MON,NULL,0,T06.AGE_MON) \n",
				"                   + DECODE(T07.AGE_MON,NULL,0,T07.AGE_MON) \n",
				"                   + DECODE(T08.AGE_MON,NULL,0,T08.AGE_MON) \n",
				"                   + DECODE(T09.AGE_MON,NULL,0,T09.AGE_MON) \n",
				"                   + DECODE(T10.AGE_MON,NULL,0,T10.AGE_MON) \n",
		};
		for(int c=0; c<arrCon.length-2; c++){
			sql += arrSel_03[c];
		}
		sql += "                    ) AS AGE_MON  \n";
		sql += "                  ,T01.AGE_01  \n";
		sql += "                  ,T02.AGE_02  \n";

		String[] arrSel_04 = new String[]{
			   "                  ,T03.AGE_03 \n",
			   "                  ,T04.AGE_04 \n",
			   "                  ,T05.AGE_05 \n",
			   "                  ,T06.AGE_06 \n",
			   "                  ,T07.AGE_07 \n",
			   "                  ,T08.AGE_08 \n",
			   "                  ,T09.AGE_09 \n",
			   "                  ,T10.AGE_10 \n",
		};
		for(int j=0; j<arrCon.length-2; j++){
			sql += arrSel_04[j];
		}

		sql += "            FROM  ( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_TOT  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  1=1  \n";
		sql += "                    [1]  \n";
		sql += "                    GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		sql += "                   ) A  \n";
		sql += "                 ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AGE_01  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) <= "+arrCon[0]+"  \n";
		sql += "                    [2]  \n";
		sql += "                    GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		sql += "                   ) T01  \n";
		sql += "                 ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_02  \n";
		sql += "                           ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		sql += "                    FROM   VI_T_CM_PERSON  \n";
		sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[1]+"  \n";
		if(arrCon[2] != ""){
			sql += "                AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[2]+"  \n";
		}
		sql += "                    [3]  \n";
		sql += "                    GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		sql += "                   ) T02  \n";

//		 조회할 인라인 뷰
		String T03 = "";
		T03 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_03  \n";
		T03 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T03 += "               FROM   VI_T_CM_PERSON  \n";
		T03 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[2]+"  \n";
		if(arrCon[3] != ""){
			T03 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[3]+"  \n";
		}
		T03 += "               [4]  \n";
		T03 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T03 += "               ) T03  \n";

		String T04 = "";
		T04 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_04  \n";
		T04 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T04 += "               FROM   VI_T_CM_PERSON  \n";
		T04 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[3]+"  \n";
		if(arrCon[4] != ""){
			T04 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[4]+"  \n";
		}
		T04 += "               [5]  \n";
		T04 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T04 += "               ) T04  \n";

		String T05 = "";
		T05 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_05  \n";
		T05 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T05 += "               FROM   VI_T_CM_PERSON  \n";
		T05 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[4]+"  \n";
		if(arrCon[5] != ""){
			T05 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[5]+"  \n";
		}
		T05 += "               [6]  \n";
		T05 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T05 += "               ) T05  \n";


		String T06 = "";
		T06 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_06  \n";
		T06 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T06 += "               FROM   VI_T_CM_PERSON  \n";
		T06 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[5]+"  \n";
		if(arrCon[6] != ""){
			T06 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[6]+"  \n";
		}
		T06 += "               [7]  \n";
		T06 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T06 += "               ) T06  \n";

		String T07 = "";
		T07 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_07  \n";
		T07 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T07 += "               FROM   VI_T_CM_PERSON  \n";
		T07 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[6]+"  \n";
		if(arrCon[7] != ""){
			T07 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[7]+"  \n";
		}
		T07 += "               [8]  \n";
		T07 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T07 += "               ) T07  \n";

		String T08 = "";
		T08 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_08  \n";
		T08 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T08 += "               FROM   VI_T_CM_PERSON  \n";
		T08 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[7]+"  \n";
		if(arrCon[8] != ""){
			T08 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[8]+"  \n";
		}
		T08 += "               [9]  \n";
		T08 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T08 += "               ) T08  \n";

		String T09 = "";
		T09 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_09  \n";
		T09 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T09 += "               FROM   VI_T_CM_PERSON  \n";
		T09 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[8]+"  \n";
		if(arrCon[9] != ""){
			T09 += "           AND    FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) < "+arrCon[9]+"  \n";
		}
		T09 += "               [10]  \n";
		T09 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T09 += "               ) T09  \n";

		String T10 = "";
		T10 += "            ,( SELECT DECODE(TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1)), NULL, '기타',TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))) AS ADR_NM, COUNT(*) AS AGE_10  \n";
		T10 += "                     ,SUM(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)) AS AGE_MON  \n";
		T10 += "               FROM   VI_T_CM_PERSON  \n";
		T10 += "               WHERE  FLOOR(MONTHS_BETWEEN('"+BIR_YMD_SHR+"', BIR_YMD)/12) >= "+arrCon[9]+"  \n";
		T10 += "               [11]  \n";
		T10 += "               GROUP BY TRIM(SUBSTR(ADR_CT, 0, INSTR(ADR_CT, ' ')-1))  \n";
		T10 += "               ) T10  \n";


		String[] arrTbl = new String[]{
				T03,
				T04,
				T05,
				T06,
				T07,
				T08,
				T09,
				T10,
		};
		for(int k=0; k<arrCon.length-2; k++){
			sql += arrTbl[k];
		}

		sql += "            WHERE  A.ADR_NM = T01.ADR_NM(+)  \n";
		sql += "            AND    A.ADR_NM = T02.ADR_NM(+)  \n";

		String[] arrJoin = new String[]{
			   "            AND    A.ADR_NM = T03.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T04.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T05.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T06.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T07.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T08.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T09.ADR_NM(+)  \n",
			   "            AND    A.ADR_NM = T10.ADR_NM(+)  \n",
		};
		for(int l=0; l<arrCon.length-2; l++){
			sql += arrJoin[l];
		}

		sql += "            ORDER  BY ADR_SEQ, ADR_NM  \n";
		sql += "           ) K,  \n";
		sql += "          ( SELECT 1 AS NO FROM DUAL UNION ALL  \n";
		sql += "            SELECT 2 AS NO FROM DUAL   \n";
		sql += "           ) L    \n";
		sql += "      GROUP BY L.NO, DECODE(L.NO, 1, K.ADR_SEQ, DECODE(L.NO, 1, '0', '999')), DECODE(L.NO, 1, K.ADR_NM, '합계')  \n";
		sql += "     ) I  \n";
		sql += "  ORDER BY I.ADR_SEQ, I.ADR_NM   \n";

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString(),
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    AbstractDAO aaa= new AbstractDAO("default");

	    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	    extquery hnwExtQuery = new extquery();


		/** 필드값 세팅 **/
		String 	colStr  =   "RN,JOB_NM,AGE_TOT_CNT,AGE_TOT_PER,AGE_AVG,AGE_01_CNT,AGE_01_PER,AGE_02_CNT,AGE_02_PER,AGE_03_CNT,AGE_03_PER,AGE_04_CNT,AGE_04_PER,AGE_05_CNT,AGE_05_PER,AGE_06_CNT,AGE_06_PER,AGE_07_CNT,AGE_07_PER,AGE_08_CNT,AGE_08_PER,AGE_09_CNT,AGE_09_PER,AGE_10_CNT,AGE_10_PER";
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

	}



%>