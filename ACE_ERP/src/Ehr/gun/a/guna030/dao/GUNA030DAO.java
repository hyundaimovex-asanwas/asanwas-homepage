package Ehr.gun.a.guna030.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA030DAO extends AbstractDAO {
    /** 
     * GUNA030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이 
     * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
     * @param p_conn	Connection
     * @param p_tr		TrBox
     * @throws CException
     */
    public GUNA030DAO(String p_conn, TrBox p_tr) throws CException {
    	
        /** SuperClass의 생성자 호출 **/
        super(p_conn, p_tr);
        
    }
    
    /**
     * 근태휴일날짜조회용  DAO메소드
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA030_SHR(CBox p_box) throws CException {
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_SHR");
        
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
    public GauceDataSet  GUNA030_SHR_01(CBox p_box) throws CException {
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_SHR_01");
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                
        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT메소드 호출 **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }

    /**
     * 근태휴일날짜수정  DAO메소드.
     * @param vo			GauceValueObject
     * @param p_box	CBox
     * @throws CException
     */
    public void GUNA030_UPT(GauceValueObject vo, CBox p_box) throws CException {
        
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_UPT");
        
        String d_sql1 = "";
        String d_sql2 = "";
        String HOL_YN = "";
        String HOL_GBN = "";
        
        if ( vo.get("HOL_GUB").equals("평일")) {
            HOL_GBN = "0";
            HOL_YN = "N";
        }
        else if (vo.get("HOL_GUB").equals("토요일")) {
            HOL_GBN = "1";
            HOL_YN = "Y";
        }
        else if (vo.get("HOL_GUB").equals("휴일")) {
            HOL_GBN = "2";
            HOL_YN = "Y";
        }
        else if (vo.get("HOL_GUB").equals("특별휴일")) {
            HOL_GBN = "3";
            HOL_YN = "Y";
        }
        
        d_sql1 = "HOL_GBN = '" + HOL_GBN + "'";
        
        d_sql2 = "HOL_YN = '" + HOL_YN + "'";
        
        
        
        String ENONM = p_box.get("vusrid");//사번
        
        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {
        		
                d_sql1, d_sql2
                
        };
        
        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
                JSPUtil.rns(vo.get("REMARK_VAL"))
               ,ENONM
              , JSPUtil.rns(vo.get("REG_YMD"))
              
        };
        /** UPDATE메소드 호출  **/
        updateProcess(sql, bind);
        
    }
    
    /**
     * 1년치 날짜 정보를 저장하는 DAO메소드.
     * @param vo	GauceValueObject
     * @param p_box	CBox
     * @throws CException
     */
    public void GUNA030_INS(GauceValueObject vo, CBox p_box) throws CException {
        
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_INS");
        
        String REG_YM_S = "";
        String REG_YM_E = "";
        
        String REG_Y  = p_box.get("REG_Y");
        String ENONO = p_box.get("vusrid");//사번
        
        REG_YM_S     = REG_Y + "0101";
        REG_YM_E     = REG_Y + "1231";
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                REG_YM_S, REG_YM_S, REG_YM_S, ENONO, ENONO, REG_YM_E, REG_YM_S
        };
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
}
