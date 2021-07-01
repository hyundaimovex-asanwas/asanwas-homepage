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
     * GUNA200DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
     * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
     * @param p_conn	Connection
     * @param p_tr		TrBox
     * @throws CException
     */
    public GUNA200DAO(String p_conn, TrBox p_tr) throws CException {
        /** SuperClass�� ������ ȣ�� **/
        super(p_conn, p_tr);
    }

    /**
     * �������ϳ�¥��ȸ��  DAO�޼ҵ�
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA200_SHR(CBox p_box) throws CException {
    	
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR");
        
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
    public GauceDataSet  GUNA200_SHR_01(CBox p_box) throws CException {
    	
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_01");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {

        };
        
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        /** SELECT�޼ҵ� ȣ�� **/
        
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        
        return gs;
        
    }
    
    
    /**
     * DB�� �μ��� ���»�Ȳ�� ��ȸ�ϴ�  DAO�޼ҵ�
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA200_SHR_02(CBox p_box) throws CException {
    	
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_02");
		
		
        String REG_YMD = p_box.get("REG_YMD");
        
        String DPT_CD = p_box.get("DPT_CD_SHR");
        
        String YYYY = REG_YMD.substring(0,4);
        
        String MM = REG_YMD.substring(4);
        
        //System.out.println("p_box" + p_box);        
        //System.out.println("�⵵ [" + YYYY + "]");
        //System.out.println("�� [" + MM + "]");
        //System.out.println("�μ��ڵ� [" + DPT_CD + "]");

		StringBuffer sb = new StringBuffer();
		
		if(p_box.get("SESSION_TEAMCD").equals("I290")||p_box.get("SESSION_TEAMCD").equals("I144")||p_box.get("SESSION_ENONO").equals("2040062")){
			sb.append("AND B.GBN_CD = '1' \n");
		}

		Object[] sqlParam = new Object[] {
				sb.toString()			
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);        
        
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        
		Object[] bind = new Object[] {
				
        		YYYY, 
        		MM, 
        		DPT_CD
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		
		return gs;

    }

    
    
    public void  GUNA200_SHR_DPT(CBox p_box) throws CException {
    	
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA200_SHR_DPT");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {

				p_box.get("vusrid"),		// 
				
        };
        
        /** SELECT�޼ҵ� ȣ�� **/
        this.selectProcessFirstRow(sql, bind, prop);
        
		//return this.selectProcess(sql, bind, prop);

    }
    
    
    
}
