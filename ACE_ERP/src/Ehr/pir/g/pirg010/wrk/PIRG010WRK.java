package Ehr.pir.g.pirg010.wrk;

import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.imageio.ImageIO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.FileUtil;

public class PIRG010WRK {
	
    private String DIR_PATH;
    
    private String REAL_PATH;
    
    private String TEMP_PATH;
    
    public PIRG010WRK() throws BizException {
    	
        //���ǵ� path ��ȸ�� ����
        Configuration conf;
        
        try {
        	
            conf = Configuration.getInstance();
            
            DIR_PATH = conf.get("framework.file.upload.pds");
             
            //���ǵ� path�� ���� ��θ� ������
            URL filePath = new FileUtil().getClass().getResource(DIR_PATH);
            
            //���� ��ΰ� ������ ���ǵ� ��η� ������ �о��
            REAL_PATH = filePath != null ? filePath.getPath() : DIR_PATH;
            
            TEMP_PATH = REAL_PATH+File.separator+"temp";
            
        } catch (CException e) {
        	
            throw new BizException("���ε� ȯ�� ������ �����ϴ�. ������ ��ȸ�� �� �� �����ϴ�.");
            
        }
        
    }



    /**
     * temp ������ �ִ� ���� ��θ� upload ������ �ø���.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void PIRG010_SAV(CBox p_box, TrBox p_tr) throws CException {
        File dir = null;
        File file = null;

        String[] child = null;
        String fileName = null;
        String ext = null;

        InputStream is = null;

        //System.out.println("p_box==============="+p_box);        
        
        //�ӽ� ���ϵ��� ����Ʈ�� ��ȸ�� �´�.
        //dir = new File(TEMP_PATH);
        dir = new File(TEMP_PATH);
        
        //System.out.println("dir==============="+dir);
        
     
        
        if(dir.isDirectory()) {
        	
            child = dir.list();

            for(int i=0; i<child.length; i++) {
            	
                fileName = child[i];
                
                file = new File(dir, fileName);

                //System.out.println("file==============="+file);          
                
                //System.out.println("REAL_PATH==============="+REAL_PATH);                   
                REAL_PATH = "/asanwas/Ehr/file";
                //System.out.println("REAL_PATH==============="+REAL_PATH);                
                //������ ��� ������ upload ������ �ű�
                if(file.isFile()){
                	
                    ext = fileName.substring(fileName.lastIndexOf(".") + 1);

                    //System.out.println("ext==============="+ext);   
                    
                    //Ȯ���ڰ� jpg �� �༮�� ��������
                    if(ext != null && ext.equals("jpg")) {
                    	
                        try {

                            //System.out.println("REAL_PATH333333333333==============="+REAL_PATH);                         	
                            //System.out.println("fileName44444444444==============="+fileName);                         	
                            //���������� �о� stream���� ��ȯ��Ų��.
                            is = new FileInputStream(file);

                            //upload ������ ���� ������ �����Ѵ�.
                            FileUtil.createFile(REAL_PATH, fileName, is);

                            //���� ������ ���� �Ѵ�.
                            file.delete();

                        } catch (FileNotFoundException e) {
                        	
                            e.printStackTrace();
                            
                        } catch (IOException e) {
                        	
                            e.printStackTrace();
                            
                        } finally {
                        	
                            try {
                                is.close();
                                
                            } catch (IOException e) {
                            	
                            }
                        }
                    }
                }
            }
        }
    }

	/**
	 * ���������� ���ε� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PIRG010_ULD(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("dsFILE_UPLOAD");
        GauceValueObject vo = null;

        InputStream[] isList = FileUtil.getFileStream(p_tr, "dsFILE_UPLOAD", "FILE_URL");
        InputStream is = null;

        //System.out.println("p_box==============="+p_box);
        
        ParameterBlock pb = null;

        BufferedImage bi = null;
        
        File writeFile = null;

        String fileName = null;
        String ext = null;

        for (int i = 0; i < voList.size(); i++) {
        	
            vo = voList.get(i);
            
            //System.out.println("vo==============="+vo);
            
            is = isList[i];

            fileName    = vo.get("FILE_NAME");
            
            //System.out.println("fileName==============="+fileName);            
            
            ext         = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            
            //System.out.println("ext==============="+ext);                
            
            fileName    = fileName.substring(0, fileName.lastIndexOf("."));

            //System.out.println("fileName==============="+fileName);
            
            //System.out.println("TEMP_PATH1111111111111111111111111111==============="+TEMP_PATH);            
            
            try{

                    bi  = ImageIO.read(is);

                //�ӽ� ��ο� �̹����� ������ ���´�.
                writeFile = new File(TEMP_PATH+File.separator+fileName+".jpg");
                
                ImageIO.write(bi, "jpg", writeFile);
                
                this.PIRG010_SAV(p_box, p_tr);
                
            }catch(IOException e){
            	
                throw new BizException("�̹��� ���ε尡 �����Ͽ����ϴ�.");
            }
        }
	}


}
