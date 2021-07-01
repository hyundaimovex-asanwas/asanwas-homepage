package Ehr.gun.a.guna200.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA200DAO extends AbstractDAO {
    /**
     * GUNA200DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
     * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
     * @param p_conn	Connection
     * @param p_tr		TrBox
     * @throws CException
     */
    public GUNA200DAO(String p_conn, TrBox p_tr) throws CException {
        /** SuperClass의 생성자 호출 **/
        super(p_conn, p_tr);
    }

    /**
     * 근태휴일날짜조회용  DAO메소드
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA200_SHR(CBox p_box) throws CException {
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR");
        
        String REG_YMD = p_box.get("REG_YMD");
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        
        Object[] bind = new Object[] {
                REG_YMD, REG_YMD, REG_YMD, REG_YMD, REG_YMD , REG_YMD
        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT메소드 호출 **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }

    /**
     * DB에 생성되어있는 근태휴일날짜 년도를 조회하는  DAO메소드
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA200_SHR_01(CBox p_box) throws CException {
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_01");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {

        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT메소드 호출 **/
        
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }
    
    
    /**
     * DB에 부서별 근태상황을 조회하는  DAO메소드
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA200_SHR_02(CBox p_box) throws CException {
    	
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_02");
		
		
        String REG_YMD = p_box.get("REG_YMD");
        
        String DPT_CD = p_box.get("DPT_CD_SHR");
        
        String YYYY = REG_YMD.substring(0,4);
        
        String MM = REG_YMD.substring(4);
        
        //System.out.println("p_box" + p_box);        
        //System.out.println("년도 [" + YYYY + "]");
        //System.out.println("월 [" + MM + "]");
        //System.out.println("부서코드 [" + DPT_CD + "]");

		StringBuffer sb = new StringBuffer();
		
		if(p_box.get("SESSION_TEAMCD").equals("I290")||p_box.get("SESSION_TEAMCD").equals("I144")||p_box.get("SESSION_ENONO").equals("2040062")){
			sb.append("AND B.GBN_CD = '1' \n");
		}

		Object[] sqlParam = new Object[] {
				sb.toString()			
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);        
        
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        
		Object[] bind = new Object[] {
				
        		YYYY, 
        		MM, 
        		DPT_CD
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		
		return gs;

    }

    
    
    public void  GUNA200_SHR_DPT(CBox p_box) throws CException {
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_DPT");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {

				p_box.get("vusrid"),		// 
				
        };
        
        /** SELECT메소드 호출 **/
        this.selectProcessFirstRow(sql, bind, prop);
        
		//return this.selectProcess(sql, bind, prop);

    }
    
    
    
}
