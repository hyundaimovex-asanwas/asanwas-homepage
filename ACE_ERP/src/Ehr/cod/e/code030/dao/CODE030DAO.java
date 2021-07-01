package Ehr.cod.e.code030.dao;

import Ehr.common.util.JSPUtil;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE030DAO extends AbstractDAO {
	/**
	 * PIRA020DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 사용자 권한 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR");

		
		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")) && !(p_box.get("vusrid").equals("6070001")) && !(p_box.get("vusrid").equals("6050006"))){
			
			sb.append("WHERE PRO_STS = '6'");
		}
	
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);			
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	  	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("ENO_NO"),	    // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * 급여지급액 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    	// 해당월
				p_box.get("SAL_GBN"),	    	// 급상여구분
				p_box.get("ENO_NO"),	   	 	// 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * 일반 공제 내역 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 일반 공제 내역 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("ENO_NO"),	    // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}




	/**
	 * 저축/대출 내역 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 저축/대출 내역 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_03");

		StringBuffer sb = new StringBuffer();

        if( p_box.get("ENO_NO").equals("2040038")){
			sb.append(" UNION SELECT '하이드림' AS BNK_NM, '대한생명' AS COMM_NM,'저축' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_BAK  FROM DUAL  ");
		}

        //System.out.println(p_box.get("ENO_NO"));

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    	// 해당월
				p_box.get("SAL_GBN"),	    	// 급상여구분
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    	// 해당월
				p_box.get("SAL_GBN"),	   		// 급상여구분
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),

		};

		prop.add("BNK_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("SAV_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUBUN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * 작업 완료 여부 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet CODE030_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 작업 완료 여부 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("ENO_NO"),	    // 사번
		};

		/** selectProcess메소드 호출 **/
		return selectProcess(sql, bind, prop);
	}



	/**
	 * 누계조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_05(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_05");

		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")|| p_box.get("vusrid").equals("6070001")|| p_box.get("vusrid").equals("6050006"))){
			
			sb.append("AND B.PRO_STS = '6'");
		}
	
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);	
		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("SAL_GBN"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),

		};

		prop.add("SALT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("INCM_TAX", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CITI_TAX", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINU_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NPEN_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINS_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}





	/**
	 * 급여지급액 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_06(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_06");

		//작업완료 여부를 조회
		GauceDataSet ds = this.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

        //System.out.println(p_box.get("SESSION_ROLE_CD"));

		StringBuffer sb = new StringBuffer();
		if(!(p_box.get("SESSION_ROLE_CD").equals("1001")|| p_box.get("SESSION_ROLE_CD").equals("1002")|| Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6)){
			sb.append("WHERE PRO_STS = '6'");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	  	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("ENO_NO"),	    // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 인쇄 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT(CBox p_box) throws CException {


	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    // 해당월
				p_box.get("SAL_GBN"),	    // 급상여구분
				p_box.get("ENO_NO"),	    // 사번
	    };

	    this.selectProcessFirstRow(sql, bind, prop);		

	}

	/**
	 * 인쇄 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT2(CBox p_box) throws CException {

		/** 외부 XML에서 저축/대출 내역 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT2");

		StringBuffer sb = new StringBuffer();

        if( p_box.get("ENO_NO").equals("2040038")){
			sb.append(" UNION SELECT '하이드림' AS BNK_NM, '대한생명' AS COMM_NM,'저축' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_BAK  FROM DUAL  ");
		}

        //System.out.println(p_box.get("ENO_NO"));

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    	// 해당월
				p_box.get("SAL_GBN"),	    	// 급상여구분
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY"),	    	// 해당년
				p_box.get("PIS_MM"),	    	// 해당월
				p_box.get("SAL_GBN"),	   		// 급상여구분
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("ENO_NO"),	    	// 사번
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),

		};

		prop.add("BNK_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("SAV_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUBUN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
	/**
	 * 인쇄 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT3(CBox p_box) throws CException {

		/** 외부 XML에서 급상여지급액 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT3");

		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")|| p_box.get("vusrid").equals("6070001")|| p_box.get("vusrid").equals("6050006"))){
			
			sb.append("AND B.PRO_STS = '6'");
		}
	
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);	
		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("SAL_GBN"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),

		};

		prop.add("SALT_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("INCM_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CITI_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINU_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NPEN_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINS_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
}
