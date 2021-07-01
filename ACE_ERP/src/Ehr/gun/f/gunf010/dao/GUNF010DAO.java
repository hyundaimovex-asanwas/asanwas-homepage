package Ehr.gun.f.gunf010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF010DAO extends AbstractDAO {
	/**
	 * GUND060DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ��������  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF010_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF010_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM"),				
				p_box.get("ENO_NO"),		
				p_box.get("ENO_NO"),					
				p_box.get("PIS_YM"),		
				
		};
		
		/*
        prop.add("YRP_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_ATT_H"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_YRP"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MPH_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("UMPH_CNT"   ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("LMPH_CNT"   ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("TOTAL"      ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        */
		
        prop.add("WRK_TIME"      ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	/**
	 * �����߻�����  ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF010_SHR_DTL(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF010_SHR_DTL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),

		};
		
        //prop.add("YRP_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("YRP_ATT_H"  ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("REM_YRP"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("MPH_CNT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("UMPH_CNT"   ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("LMPH_CNT"   ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
          
        
		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	

	
	/**
	 * ���� ��ȸ��  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF010_SHR_WEEK(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF010_SHR_WEEK");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YMD"),

		};
		

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	
	
}
