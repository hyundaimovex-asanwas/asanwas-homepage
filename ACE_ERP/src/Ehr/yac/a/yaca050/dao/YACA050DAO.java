package Ehr.yac.a.yaca050.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA050DAO extends AbstractDAO {

	/**
	 * INSB050DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void YACA050_PRT_15_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"yaca050_15",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"P"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA050_SHR(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_14");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
    }    
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_142");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_15");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * 연말정산결과조회를 가져온다. 출력물  1,2page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		//prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * 연말정산결과조회를 가져온다. 출력물  1,2page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		//prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * 연말정산결과조회를 가져온다.  출력물 3page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_3(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_3");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    /**
     * 연말정산결과조회를 가져온다.  출력물 3page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_3(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_3");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * 연말정산결과조회를 가져온다.   출력물 4page HEAD
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("ENO_NO")        
        };

        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * 연말정산결과조회를 가져온다.     출력물 4page 퇴직연금
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_1(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_1");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * 연말정산결과조회를 가져온다.    출력물 4page 연금저축
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_2(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_2");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       

    
    /**
     * 연말정산결과조회를 가져온다.  출력물 4page 주택마련
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_3(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_3");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * 연말정산결과조회를 가져온다.  출력물 4page 장기집합투자증권
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_4(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_4");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * 연말정산결과조회를 가져온다.   출력물 4page HEAD
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4");
        
        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("ENO_NO")        
        };

        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * 연말정산결과조회를 가져온다.     출력물 4page 퇴직연금
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_1(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_1");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * 연말정산결과조회를 가져온다.    출력물 4page 연금저축
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_2(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_2");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
        //값 보내고 DataSet 가져오기
        //return this.selectProcess(Query, bind, prop);        
        
    }       

    
    /**
     * 연말정산결과조회를 가져온다.  출력물 4page 주택마련
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_3(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_3");
        
        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * 연말정산결과조회를 가져온다.  출력물 4page 장기집합투자증권
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_4(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_4");
        
       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding 하기
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
}
