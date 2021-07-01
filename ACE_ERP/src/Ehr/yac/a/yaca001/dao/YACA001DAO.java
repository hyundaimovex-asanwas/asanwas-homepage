package Ehr.yac.a.yaca001.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.DynamicValueObject;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA001DAO extends AbstractDAO {

	public YACA001DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * JSP를 위해 생성자 추가
     * Transaction 은 처리하지않음
     * @param p_conn
     * @throws CException
     */
    public YACA001DAO(String p_conn) throws CException {
        super(p_conn);
    }
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_14(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_14");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    

    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_15(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_15");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    
    

    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_142(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_142");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }      

    
    /**
     * 연말정산  조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_14_AB(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_AB");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }    
    

    
    public DynamicValueObject YACA001_SHR_FILE_15_AB(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_15_AB");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    

    /**
     * 연말정산  조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_14_AB_142(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_AB_142");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }        
    
    
	/**
	 * 연말정산
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_14_ETC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_ETC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}    
    
	/**
	 * 연말정산
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_15_ETC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_15_ETC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}    
    

	/**
	 * 연말정산
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_14_ETC_142(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_ETC_142");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}       

    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    

    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }       


    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }
    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02_142(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02_142");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    
    /**
     * 연말정산 의료비 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02_15(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02_15");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }
    
    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03_15(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03_15");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    /**
     * 연말정산 기부금 조회를 가져온다.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03_142(CBox p_box) throws CException {

    	/** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03_142");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query 실행 후 자료 결과값을 반환 **/
        return this.selectProcessDvo(sql, bind);

    }        
    
}
