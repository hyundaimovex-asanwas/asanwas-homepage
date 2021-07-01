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
     * GUNA030DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ���� 
     * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
     * @param p_conn	Connection
     * @param p_tr		TrBox
     * @throws CException
     */
    public GUNA030DAO(String p_conn, TrBox p_tr) throws CException {
    	
        /** SuperClass�� ������ ȣ�� **/
        super(p_conn, p_tr);
        
    }
    
    /**
     * �������ϳ�¥��ȸ��  DAO�޼ҵ�
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA030_SHR(CBox p_box) throws CException {
    	
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_SHR");
        
        String REG_YMD = p_box.get("REG_YMD");
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        
        Object[] bind = new Object[] {
        		
                REG_YMD, REG_YMD, REG_YMD, REG_YMD, REG_YMD , REG_YMD         
        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT�޼ҵ� ȣ�� **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }
    
    /**
     * DB�� �����Ǿ��ִ� �������ϳ�¥ �⵵�� ��ȸ�ϴ�  DAO�޼ҵ�
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA030_SHR_01(CBox p_box) throws CException {
    	
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_SHR_01");
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                
        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT�޼ҵ� ȣ�� **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }

    /**
     * �������ϳ�¥����  DAO�޼ҵ�.
     * @param vo			GauceValueObject
     * @param p_box	CBox
     * @throws CException
     */
    public void GUNA030_UPT(GauceValueObject vo, CBox p_box) throws CException {
        
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_UPT");
        
        String d_sql1 = "";
        String d_sql2 = "";
        String HOL_YN = "";
        String HOL_GBN = "";
        
        if ( vo.get("HOL_GUB").equals("����")) {
            HOL_GBN = "0";
            HOL_YN = "N";
        }
        else if (vo.get("HOL_GUB").equals("�����")) {
            HOL_GBN = "1";
            HOL_YN = "Y";
        }
        else if (vo.get("HOL_GUB").equals("����")) {
            HOL_GBN = "2";
            HOL_YN = "Y";
        }
        else if (vo.get("HOL_GUB").equals("Ư������")) {
            HOL_GBN = "3";
            HOL_YN = "Y";
        }
        
        d_sql1 = "HOL_GBN = '" + HOL_GBN + "'";
        
        d_sql2 = "HOL_YN = '" + HOL_YN + "'";
        
        
        
        String ENONM = p_box.get("vusrid");//���
        
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {
        		
                d_sql1, d_sql2
                
        };
        
        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		
                JSPUtil.rns(vo.get("REMARK_VAL"))
               ,ENONM
              , JSPUtil.rns(vo.get("REG_YMD"))
              
        };
        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(sql, bind);
        
    }
    
    /**
     * 1��ġ ��¥ ������ �����ϴ� DAO�޼ҵ�.
     * @param vo	GauceValueObject
     * @param p_box	CBox
     * @throws CException
     */
    public void GUNA030_INS(GauceValueObject vo, CBox p_box) throws CException {
        
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA030_INS");
        
        String REG_YM_S = "";
        String REG_YM_E = "";
        
        String REG_Y  = p_box.get("REG_Y");
        String ENONO = p_box.get("vusrid");//���
        
        REG_YM_S     = REG_Y + "0101";
        REG_YM_E     = REG_Y + "1231";
        
        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
                REG_YM_S, REG_YM_S, REG_YM_S, ENONO, ENONO, REG_YM_E, REG_YM_S
        };
        
        /** INSERT�޼ҵ� ȣ��  **/
        insertProcess(sql, bind);
    }
    
}
