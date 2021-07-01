package Ehr.yac.a.yaca011.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA011DAO extends AbstractDAO {

	public YACA011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA011_SHR(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA011_SHR_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    public void YACA011_SHR_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA011_SHR_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    public void YACA011_UPT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("yac", "YACA011_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("FUN_CNT"),
				vo.get("ENO_NO"),          		//TAG
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
    } 
    
    public void YACA011_UPT_14(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("yac", "YACA011_UPT_14");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("FUN_CNT"),
				vo.get("ENO_NO"),          		//TAG
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
    }     
    
}
