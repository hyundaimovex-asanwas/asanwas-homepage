package Ehr.yac.a.yaca050.wrk;

import Ehr.pir.i.piri010.dao.PIRI010DAO;
import Ehr.yac.a.yaca020.dao.YACA020DAO;
import Ehr.yac.a.yaca050.dao.YACA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA050WRK {
    private YACA050DAO dao = null;
    private String connectionName = "default";   
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_SHR(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_SHR(p_box);
        
    } 
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_SHR_14(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA050_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_SHR_142(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA050_SHR_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_SHR_15(CBox p_box, TrBox p_tr) throws CException {
    	

        dao = new YACA050DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA050_SHR_15(p_box));     //1.�������� ������ �����ͼ� DS �� ���    
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 1,2 page
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_142(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 1,2 page
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        YACA050DAO dao2 = new YACA050DAO("default", p_tr);      
        
        dao.YACA050_PRT_15(p_box);

		/** ��������ó�� ���� ���  **/
		dao2.YACA050_PRT_15_ACC(p_box);        
        
        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 3 page
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_3(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_142_3(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 3 page
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_3(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_15_3(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page head
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_4(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_142_4(p_box);
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ��������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_4_1(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_142_4_1(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ��������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_4_2(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_142_4_2(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_4_3(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_142_4_3(p_box);
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ���������������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_142_4_4(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_142_4_4(p_box);
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page head
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_4(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_15_4(p_box);
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ��������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_4_1(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_15_4_1(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ��������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_4_2(CBox p_box, TrBox p_tr) throws CException {
    	
        //dao = new YACA050DAO(connectionName, p_tr);
        
        //dao.YACA050_SHR_14(p_box);
        
        //dao = new YACA020DAO(connectionName, p_tr);
        dao = new YACA050DAO(connectionName, p_tr);
        
        dao.YACA050_PRT_15_4_2(p_box);

        //p_tr.setOutDataSet("gcds_print"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        
        //p_tr.setOutDataSet("dsT_AC_RETACC"  , dao.YACA050_PRT_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        //p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���        
        
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_4_3(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_15_4_3(p_box);
    }     
    
    /**
     * �������� �����ȸ�� �����´�. - ��� 4 page ���������������
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA050_PRT_15_4_4(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new YACA050DAO(connectionName, p_tr);
        dao.YACA050_PRT_15_4_4(p_box);
    }     
    
}

