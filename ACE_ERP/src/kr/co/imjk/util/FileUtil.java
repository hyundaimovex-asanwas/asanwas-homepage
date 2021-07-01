package kr.co.imjk.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class FileUtil{

	/**
	 * ������ ������ �д´�<p>
	 *
	 * @param filename(String) ������ Ǯ�ּ�
	 * @return sb(String)
	 */
	public static String readFile(String filename) throws FileNotFoundException, IOException
	{
		StringBuffer sb = new StringBuffer();

	    try{

			FileReader fr = new FileReader(filename); // ������ �д´�.
			BufferedReader br = new BufferedReader(fr); // ������ ���ۿ� ��´�.
			String line;
			try{

				while((line=br.readLine())!=null){
					sb.append(line);
				}

			}catch(FileNotFoundException ex){
				//System.out.println("File not fount :" + filename);
			}catch(IOException ex){
				//System.out.println("IOException :" + ex.getMessage());
			}finally{
				if(fr!=null){
					try{
						fr.close();
					}catch(Exception e){}
				}
				if(br!=null){
					try{
						br.close();
					}catch(Exception e){}
				}
			}
		}catch(FileNotFoundException ex){
			//System.out.println("File not fount :" + filename);
		}

		return sb.toString();
	}
    
    /**
     * ���丮�� ������� ����<p>
     * 
     * @param abs_dir ������
     */
    public static void mkdirs(String abs_dir){
        File f = new File(abs_dir);
        if(!f.exists()){
            f.mkdirs();
        }
    }
}
