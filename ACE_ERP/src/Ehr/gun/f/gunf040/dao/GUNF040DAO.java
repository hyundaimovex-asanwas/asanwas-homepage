package Ehr.gun.f.gunf040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF040DAO extends AbstractDAO {
	/**
	 * GUND060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ��������  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
			
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),	
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),					
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),	
				p_box.get("PIS_YYYY"),
				p_box.get("DPT_CD"),
		};
		

        prop.add("WRK_TIME_01",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_02",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_03",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_04",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_05",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_06",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_07",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_08",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_09",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_10",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_11",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_12",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	
	/**
	 * ���� �Ҽ� ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),

		};
		

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	/**
	 * �����߻�����  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR_DTL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR_DTL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),		
				p_box.get("ENO_NO"),					
				p_box.get("PIS_YM"),	

		};
		
		
		
        prop.add("WRK_TIME"      ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
          
        
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	


	
	
	
}
