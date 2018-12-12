/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package adventofcode;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 *
 * @author simon
 */
public class Day1
{
	String fileName = "day1.txt";
	
	public Day1(String inputpath)
	{
		fileName = inputpath;
	}
	
	public int getAnswer()
	{
		String line = "";
		Integer answer = 0;
		
		try
		{
			 String current = new java.io.File( "." ).getCanonicalPath();
					System.out.println("Current dir:"+current);
			 String currentDir = System.getProperty("user.dir");
					System.out.println("Current dir using System:" +currentDir);
			FileReader fileReader = new FileReader(fileName);
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			
			while((line = bufferedReader.readLine()) != null)
			{
                Integer calculation = Integer.parseInt(line);
				answer = answer + calculation;
            }   

            // Always close files.
            bufferedReader.close(); 
		}
		catch(FileNotFoundException ex)
		{
            System.out.println(
                "Unable to open file '" + 
                fileName + "'");                
        }
        catch(IOException ex)
		{
            System.out.println(
                "Error reading file '" 
                + fileName + "'");                  
            // Or we could just do this: 
            // ex.printStackTrace();
        }
		
		return answer;
	}
}
