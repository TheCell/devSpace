/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package adventofcode;

import java.io.File;

/**
 *
 * @author simon
 */
public class Adventofcode
{

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
	{
        Day1 day1 = new Day1("inputs" + File.separator + "day1.txt");
		System.out.println(day1.getAnswer());
    }

}
