package employee;
import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import general.GUI;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 * Shows the current orders of the restaurant in an editable JTable
 * @author Younes Saoudi
 */
public class CurrentOrders {

	//Class Attributes//

	// Swing Items
	private JFrame window;
	private JTable table;
	private JScrollPane sp;
	private JLabel logo, footerLabel, text, l1, l2, l3, l4,l5;
	private JTextField t2, tDate, tTablenm, tPayment;
	private JButton Return, Refresh, Clear;
	private JPanel headLeft, headCenter, headRight, footer, tablepanel;
	private Color Background;
	private JComboBox<String> comboBoxPayment,	comboBoxTableNm,comboBoxDate,comboBoxHour;
	
	private static final String[] COLUMN_NAMES = {"TableNm", "Payment", "Status","Order","Price","Customer","Created"};
	private String[][] orders; //The 2D Array that will contain each order's details
	private final Employee Employee;
	private static final String startDate = "11/04/2020 00:00:00";

	//Button Listeners
	private final ActionListener B_Return = new Return(); //Return button's listener
	private final ActionListener B_Refresh = new Refresh();
	private final ActionListener B_Clear  = new actionClear();

	/**
	 * Opens a window containing an editable JTable of the current orders
	 * @param Employee The Employee who is checking/modifying the current orders
	 * @author Younes Saoudi
	 */
	public CurrentOrders(Employee Employee) {
		this.Employee = Employee;

		GUI MenuCommandes = new GUI(); //Using the methods implemented in GUI.java
		this.Background = new Color(235, 192, 81);

		//Create maximised JFrame and getting its dimensions
		this.window = MenuCommandes.createWindow("Current Orders", 0, 0);
		this.window.setExtendedState(this.window.getExtendedState() | JFrame.MAXIMIZED_BOTH);
		this.window.getContentPane().setBackground(Background);
		
		//Getting the maximum window size
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		int width = screenSize.width; //1536
		int height = screenSize.height;//864
		int actual_height = height - height * 40/864 - height * 75/864  -5; //Height between footer and header

		//HEADER
		this.headLeft = MenuCommandes.createPanel(0, 0, width *176/1536, height * 40/864, Background );
		this.logo = MenuCommandes.createLabel("E24 Restaurant 2020", 10, (height * 40/864)/2, 120, 40);
		this.headLeft.add(logo);
		this.window.add(this.headLeft);

		this.headCenter = MenuCommandes.createPanel(width * 176/1536, 0, width * 1024/1536,  height * 40/864, Background);
		this.window.add(this.headCenter);

		this.headRight = MenuCommandes.createPanel(width * 176/1536 + width * 1024/1536, 0, width * 336/1536,  height * 40/864, Background);
		this.text = MenuCommandes.createLabel("Current Orders", 10, (height * 40/864)/2, 200, 40);
		this.headRight.add(text);
		this.window.add(this.headRight);

		//Import the orders database       
		this.orders  = importOrders(false);
		//Setting up the column names
		String[] columnNames = { "Table Number","Payment Method","Order Status", "Order", "Paid", "Full Name of Customer","Creation Date"};
		
		//Setting up the table
		this.tablepanel = MenuCommandes.createPanel(1, height * 40/864, width, actual_height - 210 *height/864, Color.WHITE); //Table panel
		DefaultTableModel model = new DefaultTableModel(orders, columnNames);
		this.table = new JTable(model);  //Table
		
		//Setting up the table's sorter and filters
		TableRowSorter<DefaultTableModel> sorter = new TableRowSorter<DefaultTableModel>(model);
		table.setRowSorter(sorter);
		this.sp = new JScrollPane(table); //Table with a JScrollPane
		
		//Setting up the dimensions of JTable and Scrollable size
		table.setPreferredScrollableViewportSize(new Dimension(width-width*20/1536, actual_height - 250*height/864)); //Table dimension
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		table.setFillsViewportHeight(true); 

		//Table Listener
		table.getModel().addTableModelListener(new TableModelListener() {
			public void tableChanged(TableModelEvent e) {
				int row = e.getFirstRow(); //Get the row that was modified
				int column = e.getColumn(); //Get the column that was modified
				TableModel model = (TableModel)e.getSource(); //Get the modified TableModel
				String data = (String) model.getValueAt(row, column); //Get the new value of the modified data
				String [][] OrderIDs = importOrders(true); //Import *only* OrderIDs from the database
				try{
					editOrder(Employee, OrderIDs[row][0], column, data); //Edit the DataBase (see editOrder JDOC for more info)
				} catch(java.lang.ArrayIndexOutOfBoundsException error) {
					//If there is an error, the window is refreshed.
					new CurrentOrders(Employee);
					window.dispose();
					Refresh.repaint();	            	
				}

			}
		});
		
		//Set table column width
		this.table.getColumnModel().getColumn(0).setPreferredWidth(width*70/1536);
		this.table.getColumnModel().getColumn(1).setPreferredWidth(width*100/1536);
		this.table.getColumnModel().getColumn(2).setPreferredWidth(width*100/1536);
		this.table.getColumnModel().getColumn(3).setPreferredWidth(width*946/1536);
		this.table.getColumnModel().getColumn(4).setPreferredWidth(width*70/1536);
		this.table.getColumnModel().getColumn(5).setPreferredWidth(width*110/1536);
		this.table.getColumnModel().getColumn(6).setPreferredWidth(width*160/1536);
		this.table.setRowHeight(28);


		//Center all columns
		DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
		centerRenderer.setHorizontalAlignment( SwingConstants.CENTER );		
		this.table.getColumnModel().getColumn(0).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(1).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(2).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(3).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(4).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(5).setCellRenderer( centerRenderer );
		this.table.getColumnModel().getColumn(6).setCellRenderer( centerRenderer );

		//Making an Combo Box for the Order Status Column
		TableColumn StatusColumn = table.getColumnModel().getColumn(2);
		JComboBox<String> comboBox = new JComboBox<String>();
		comboBox.addItem("Done");
		comboBox.addItem("In Progress");
		comboBox.addItem("Delayed");
		comboBox.addItem("Need Assistance!");
		StatusColumn.setCellEditor(new DefaultCellEditor(comboBox));

		//Making an Combo Box for the Order Type Column (Takeout or Table Number)
		TableColumn TableNumberColumn = table.getColumnModel().getColumn(0);
		JComboBox<String> comboBox2 = new JComboBox<String>();
		comboBox2.addItem("TAKEOUT");
		//50 tables in total
		for (int i=1; i<=50; i++) {
			comboBox2.addItem("N." + (int) i/10 + i%10);
		}
		TableNumberColumn.setCellEditor(new DefaultCellEditor(comboBox2));

		//Making an Combo Box for the Payment Option column
		TableColumn PaymentColumn = table.getColumnModel().getColumn(1);
		JComboBox<String> comboBox3 = new JComboBox<String>();
		comboBox3.addItem("Cash");
		comboBox3.addItem("Credit Card");
		PaymentColumn.setCellEditor(new DefaultCellEditor(comboBox3));
		
		//Making a Combo Box for the Date filter
		comboBoxDate = new JComboBox<String>();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date Date = new Date();
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(formatter.parse(startDate)); //formatting the date under the dd/MM/yyyy format
		} catch (java.text.ParseException e1) {
			e1.printStackTrace();
		}
		Date dynamicDate = cal.getTime();
		comboBoxDate.addItem(""); //first filter is always empty
		//Adding all days ever since the creation of the restaurant to the date filter
		while (dynamicDate.before(Date)) {
			comboBoxDate.addItem(formatter.format(dynamicDate));
			cal.add(Calendar.DATE,+1);
			dynamicDate = cal.getTime();
		}


		//Adding the hour filter
		comboBoxHour = new JComboBox<String>();
		comboBoxHour.addItem(""); //first filter is always empty
		//Adding all hours
		for(int i=1;i<24;i++) {
			comboBoxHour.addItem(String.valueOf(i/10)+String.valueOf(i%10));
		}
		comboBoxHour.addItem("00");
		
		//Adding the Table Number filtrer (Takeout or Table 1 to 50)
		comboBoxTableNm = new JComboBox<String>();
		comboBoxTableNm.insertItemAt("", 0); //first filter is always empty
		comboBoxTableNm.addItem("TAKEOUT");
		//50 tables in total
		for (int i=1; i<=50; i++) {
			comboBoxTableNm.addItem("N." + (int) i/10 + i%10);
		}
		comboBoxTableNm.setSelectedIndex(0);
		
		//Adding the Payment filter
		comboBoxPayment = new JComboBox<String>();
		comboBoxPayment.addItem(""); //first filter is always empty
		comboBoxPayment.addItem("Cash");
		comboBoxPayment.addItem("Credit Card");
		comboBoxPayment.setSelectedIndex(0);
		
		//Creating the labels indicating the role of each filter
		l1 = MenuCommandes.createLabel("Table Number", 60*width/1536 + 80*width/1536, 4*actual_height/5, 120, 30);
		l1.setForeground(Color.WHITE);
		l3 = MenuCommandes.createLabel("Payment Method", 370*width/1536 + 80*width/1536, 4*actual_height/5, 130, 30);
		l3.setForeground(Color.WHITE);
		l4 = MenuCommandes.createLabel("Date", 775*width/1536 + 80*width/1536, 4*actual_height/5, 130, 30);
		l4.setForeground(Color.WHITE);
		l5 = MenuCommandes.createLabel("Hour", 1105*width/1536 + 80*width/1536, 4*actual_height/5, 130, 30);
		l5.setForeground(Color.WHITE);
		
		//Setting the bounds of each JComboBox which will be used for filtering
		comboBoxTableNm.setBounds(170*width/1536 + 80*width/1536,  4*actual_height/5, 150*width/1536, 30);
		comboBoxPayment.setBounds(500*width/1536 + 80*width/1536,  4*actual_height/5, 150*width/1536, 30);
		comboBoxDate.setBounds(830*width/1536 + 80*width/1536, 4*actual_height/5, 150*width/1536, 30);
		comboBoxHour.setBounds(1160*width/1536 + 80*width/1536, 4*actual_height/5, 150*width/1536, 30);
		
		//Adding a Clear button which resets all filter to the empty filter
		Clear = MenuCommandes.createButton("Clear", width/2 - 40*width/1536, 13*actual_height/14, 80, 25, Color.WHITE, Color.BLACK);
		Clear.addActionListener(B_Clear);
		
		//Adding a custom JTextField filter which will filter out whatever the user types
		l2 = MenuCommandes.createLabel("Search Text", 365*width/1536, 7*actual_height/8, 130, 30);
		l2.setForeground(Color.WHITE);
		l2.setBackground(Background);
		t2 = MenuCommandes.createText(465*width/1536, 7*actual_height/8, 600, 30,12);
		
		//Adding the Document Listener to the custom filter
		t2.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent e) {
				search(t2.getText()); //filter the table using the contents of the JComponent
			}
			@Override
			public void removeUpdate(DocumentEvent e) {
				search(t2.getText()); //filter the table using the contents of the JComponent
			}
			@Override
			public void changedUpdate(DocumentEvent e) {
				search(t2.getText()); //filter the table using the contents of the JComponent
			}
			/**
			 * This method specifies the filters to add on each modification of this JComponent
			 * @param str The value on which the filters will be based
			 */
			public void search(String str) {
				String[] split = str.split("\\s+"); //Split the words that the user has typed using " " (space) as the split
				//Create an arraylist of rowfilters
				ArrayList<RowFilter<Object,Object>> filters = new ArrayList<RowFilter<Object,Object>>(split.length);
				//Add all the typed words to the array of filters
				for (int i =0; i<split.length;i++) {
					filters.add(RowFilter.regexFilter("(?i)" + split[i]));
				}
				//If the other filters are active then they should be taken into consideration as well
				if(!tPayment.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tPayment.getText(),1));
				}
				if(!tTablenm.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tTablenm.getText(),0));
				}
				if(!tDate.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tDate.getText(),6));
				}
				RowFilter<Object, Object> filter = RowFilter.andFilter(filters);//set an AND filter, which means all the filter in the array filter complement each other
				sorter.setRowFilter(filter); //apply the filter to the JTable
			}
		});
		
		//this JTextField will be invisible and contain the contents of the JComboBox since only JTextFields can be filtered
		tTablenm = MenuCommandes.createText(0, 0, 0, 0, 12);

		//whenever the JComboBox is changed, the JTextfield will contain its value
		comboBoxTableNm.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				tTablenm.setText(comboBoxTableNm.getSelectedItem().toString());
			}

		});
		
		//Adding the Document Listener that will filter the JTable to the JTextField, which contains the value of JComboBox
		tTablenm.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent e) {
				search(tTablenm.getText());//filter the table using the contents of the JComponent
			}
			@Override
			public void removeUpdate(DocumentEvent e) {
				search(tTablenm.getText());//filter the table using the contents of the JComponent
			}
			@Override
			public void changedUpdate(DocumentEvent e) {
				search(tTablenm.getText());//filter the table using the contents of the JComponent
			}
			public void search(String str) {
				ArrayList<RowFilter<Object,Object>> filters = new ArrayList<RowFilter<Object,Object>>(6);
				
				//If the other filters aren't inactive, then they should be taken into consideration as well
				if(!tPayment.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tPayment.getText(),1));
				}
				if(!tTablenm.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + str,0));
				}
				if(!tDate.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tDate.getText(),6));
				}
				if(!t2.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + t2.getText()));
				}
				RowFilter<Object, Object> filter = RowFilter.andFilter(filters); //set an AND filter, which means all the filter in the array filter complement each other
				sorter.setRowFilter(filter); //apply the filter to the JTable
			}
		});
		
		//this JTextField will be invisible and contain the contents of the JComboBox since only JTextFields can be filtered
		tPayment = MenuCommandes.createText(0, 0, 0, 0, 12);
		
		//whenever the JComboBox is changed, the JTextfield will contain its value
		comboBoxPayment.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				tPayment.setText(comboBoxPayment.getSelectedItem().toString());
			}

		});
		
		//Filtering
		tPayment.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent e) {
				search(tPayment.getText());
			}
			@Override
			public void removeUpdate(DocumentEvent e) {
				search(tPayment.getText());
			}
			@Override
			public void changedUpdate(DocumentEvent e) {
				search(tPayment.getText());
			}
			public void search(String str) {
				ArrayList<RowFilter<Object,Object>> filters = new ArrayList<RowFilter<Object,Object>>(6);
				if(!tPayment.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + str,1));
				}
				if(!tTablenm.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tTablenm.getText(),0));
				}
				if(!tDate.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tDate.getText(),6));
				}
				if(!t2.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + t2.getText()));
				}
				RowFilter<Object, Object> filter = RowFilter.andFilter(filters);
				sorter.setRowFilter(filter);
			}
		});
		
		//The Hours JComboBox will be disabled unless the Date JComboBox is enabled.
		comboBoxHour.setEnabled(false);
		
		//this JTextField will be invisible and contain the contents of the JComboBox since only JTextFields can be filtered
		//whenever the JComboBox is changed, the JTextfield will contain its value
		tDate = MenuCommandes.createText(0, 0, 0, 0, 12);
		comboBoxDate.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				
				//If the Date JComboBox is active (i.e., contains a filter)
				if (!comboBoxDate.getSelectedItem().equals("")) {
					comboBoxHour.setEnabled(true); //set the Hour JComboBox to editable
					
					//if the Hour JcomboBox is empty, then the only the date should be used as a filter 
					if(comboBoxHour.getSelectedItem().equals("")){
						tDate.setText(comboBoxDate.getSelectedItem().toString());
					}else {
						//else, both the date and the hour should be used as a filter
						tDate.setText(comboBoxDate.getSelectedItem().toString() 
								+" "+ comboBoxHour.getSelectedItem().toString() + ":");
					}
				} else {
					//if the Date JComboBox is empty, then the Hour JComboBox should be disabled as well. (You can't choose an hour without a date)
					comboBoxHour.setSelectedIndex(0);
					comboBoxHour.setEnabled(false);
					tDate.setText("");
				}
			}

		});
		
		//Whenever the JComboBox is modified, the corresponding JTextfield will contain its value
		//Here, the JTextField tDate contains a date under the format "dd/MM/yyyy hh:mm:sss"
		comboBoxHour.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				if(!comboBoxDate.getSelectedItem().equals("")) {
					tDate.setText(comboBoxDate.getSelectedItem().toString() 
							+" "+ comboBoxHour.getSelectedItem().toString() + ":");
					if(comboBoxHour.getSelectedItem().equals("")){
						comboBoxHour.setSelectedIndex(0);
						tDate.setText(comboBoxDate.getSelectedItem().toString());
					}
				}
			}
		});
		
		//filtering
		tDate.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent e) {
				search(tDate.getText());
			}
			@Override
			public void removeUpdate(DocumentEvent e) {
				search(tDate.getText());
			}
			@Override
			public void changedUpdate(DocumentEvent e) {
				search(tDate.getText());
			}
			public void search(String str) {
				ArrayList<RowFilter<Object,Object>> filters = new ArrayList<RowFilter<Object,Object>>(6);
				if(!tPayment.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tPayment.getText(),1));
				}
				if(!tTablenm.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + tTablenm.getText(),0));
				}
				if(!tDate.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + str,6));
				}
				if(!t2.getText().equals("")) {
					filters.add(RowFilter.regexFilter("(?i)" + t2.getText()));
				}
				RowFilter<Object, Object> filter = RowFilter.andFilter(filters);
				sorter.setRowFilter(filter);
			}
		});

		//Adding the table to the JFrame
		this.tablepanel.add(this.sp);
		this.window.add(tablepanel);
		window.add(tTablenm); tTablenm.setVisible(false);
		window.add(tPayment); tPayment.setVisible(false);
		window.add(tDate); tDate.setVisible(false);
		window.add(comboBoxDate);
		window.add(comboBoxHour);
		window.add(comboBoxTableNm);
		window.add(comboBoxPayment);
		window.add(l2);
		window.add(t2);
		window.add(l1);
		window.add(l3);
		window.add(l4);
		window.add(l5);
		window.add(Clear);

		//FOOTER

		//Making a return button
		this.Return = MenuCommandes.createButton("Return to Employee Menu", 0, 0, 100, 40, new Color(220, 53, 69), Color.WHITE);
		this.Refresh = MenuCommandes.createButton("Refresh", width - width*102/1536, (height * 8/864)/2, 95, 20, new Color(15, 125, 102), Color.WHITE);

		Return.addActionListener(this.B_Return); //The Return button's action listener
		Refresh.addActionListener(this.B_Refresh);

		//Footer items
		this.footer = MenuCommandes.createPanel(0, height*725/864, width,  height * 75/864, Background);
		this.footer.setLayout(new BorderLayout());
		this.footerLabel = MenuCommandes.createLabel("E24 Restaurant 2020 ", 0, 0, 100, 50);
		this.footer.add(this.Return, BorderLayout.NORTH);
		this.footer.add(this.footerLabel, BorderLayout.CENTER);
		this.window.add(this.footer); //Adding footer to JFrame
		this.window.add(this.Refresh);
		
		//Setting up the fonts
		try {
			GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
			Font Museo_500 = Font.createFont(Font.TRUETYPE_FONT, new File("fonts/Museo Slab W00 500.otf")).deriveFont(14f);
			ge.registerFont(Museo_500);
			Font Uniform_Medium = Font.createFont(Font.TRUETYPE_FONT, new File("fonts/Uniform Condensed Medium.ttf")).deriveFont(16f);
			ge.registerFont(Uniform_Medium);
			Font Uniform_Light = Font.createFont(Font.TRUETYPE_FONT, new File("fonts/Uniform Light.ttf")).deriveFont(15f);
			ge.registerFont(Uniform_Light);
			this.table.setFont(Museo_500);
			this.Return.setFont(Uniform_Light);
			this.Refresh.setFont(Uniform_Light);
			this.footerLabel.setFont(Uniform_Light);
			this.logo.setFont(Uniform_Light);
			this.text.setFont(Uniform_Light);

			l2.setFont(Uniform_Medium);
			t2.setFont(Uniform_Light);
			l1.setFont(Uniform_Medium);
			l3.setFont(Uniform_Medium);
			l4.setFont(Uniform_Medium);
			l5.setFont(Uniform_Medium);
			Clear.setFont(Uniform_Medium);
		} catch (IOException|FontFormatException e) {
			e.printStackTrace();
		}

		comboBoxPayment.repaint();
		comboBoxHour.repaint();
		comboBoxTableNm.repaint();
		comboBoxDate.repaint();
		this.window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE );

	}
	/**
	 * Imports all the columns of the orders database aside from OrderNm OR only the Order IDs, depending on the value of OnlyOrderID
	 * This is how the database looks like :
	 * {"Status":"","Order":"","Payment":"","TableNm":"","Price":"","Customer":"","OrderNm":"","Edits":""}
	 * @param OnlyOrderID if true, only the order IDs are imported instead of all the columns.
	 * @return String[][] The 2D Array Database
	 */
	public String[][] importOrders(boolean OnlyOrderID) {
		int orderCount = getOrderCount();
		String [][] current_orders = new String[orderCount][1];
		if(!OnlyOrderID) {
			current_orders = new String[orderCount][7];
		}
		// the above code means that if only the OrderIDs are meant to be imported, then current_orders is a vector
		// if OnlyOrderID is false however, then current_orders is a 2D String array containing all database columns (aside from the OrderIDs)
		JSONParser parser = new JSONParser();
		int i = 0;
		try {
			//Importing the database
			JSONArray orderList = (JSONArray) parser.parse(new FileReader("data/orders.json"));
			for (Object order : orderList) {
				JSONObject current_order = (JSONObject) order;

				String Status    = (String) current_order.get("Status");
				//if the order hasn't already been completed, and if we want all the columns, then
				if((!OnlyOrderID) && (!Status.equals("Done"))) {
					String TableNm   = (String) current_order.get("TableNm");
					String Payment   = (String) current_order.get("Payment");
					String FullOrder = (String) current_order.get("Order");
					String Price     = (String) current_order.get("Price");
					String Customer  = (String) current_order.get("Customer");
					String Date      = (String) current_order.get("Created");
					String [] this_order = {TableNm, Payment, Status, FullOrder, Price, Customer, Date};
					current_orders[i] = this_order;
					i++;
				} else if ((OnlyOrderID) && (!Status.equals("Done"))) {
					//else if we only want the OrderIDs of uncompleted orders:
					String OrderNm   = (String) current_order.get("OrderNm");
					String  this_order = OrderNm;
					current_orders[i][0] = this_order;
					i++;
				}               
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return current_orders;
	}
	/**
	 * returns the number of orders yet to be completed
	 * @return OrderCount The number of orders not yet completed
	 */
	public int getOrderCount() {
		JSONParser parser = new JSONParser();
		int i = 0;
		try {
			//Importing the database
			JSONArray orderList = (JSONArray) parser.parse(new FileReader("data/orders.json"));
			for (Object order : orderList) {
				JSONObject current_order = (JSONObject) order;

				String Status    = (String) current_order.get("Status");
				//if the order hasn't already been completed, and if we want all the columns, then
				if((!Status.equals("Done"))) {
					i++;
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return i;
	}

	/**
	 * Add the modification made by an employee to current orders in the database. The "Edits" column of the modifed orders will
	 * thus contain the modified column, its old and new values as well as the time and date when it was modified
	 * and the employee who made the modifications (their full name and function).
	 * @author Younes Saoudi
	 * @param Employee Employee who made the modifications
	 * @param OrderID The Order modified
	 * @param column The column modified
	 * @param NewEdit The new value of the order's column
	 */
	@SuppressWarnings("unchecked")
	public void editOrder(Employee Employee, String OrderID, int column, String NewEdit) {
		JSONParser parser = new JSONParser();
		String column_name;
		try {
			//Importing the database
			JSONArray orderList = (JSONArray) parser.parse(new FileReader("data/orders.json"));

			for (Object order : orderList) {
				JSONObject current_order = (JSONObject) order;
				String OrderNm   = (String) current_order.get("OrderNm");
				//Getting the name of the modified column
				if (column >=0 && column <=6) {
					column_name = COLUMN_NAMES[column];
				}else {
					column_name = "ILLEGAL";
				}
				//If the orderID is found
				if (OrderID.equals(OrderNm) && !column_name.equals("ILLEGAL")) {
					SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
					//Date of modification
					Date date = new Date(); 
					String Old = (String) current_order.get(column_name); //Old value before modification
					String Previous_Edits = (String) current_order.get("Edits"); //Previous edits made to the order by potentially other employees
					//adding the current edit to the list of edits:
					if(!Previous_Edits.equals("")) {
						Previous_Edits = Previous_Edits + "\n";
					}
					Previous_Edits = Previous_Edits 
							+ Employee.getFirstName() + " " + Employee.getLastName() 
							+ " (" + Employee.getFunction() + " " + Employee.getId() +")"
							+ " modified order's " + column_name +":\n" 
							+ "\t Old version: " + Old +"\n"
							+ "\t Modification: " + NewEdit
							+ "\n\t Time: " + formatter.format(date) ; 
					current_order.replace(column_name, NewEdit); //replace the old value with the new one
					current_order.replace("Edits", Previous_Edits); //replace the old list of edits with the new one
					try (FileWriter file = new FileWriter("data/orders.json")) {
						//Updating the database
						file.write(orderList.toJSONString());
						file.flush();

					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Refreshes the window
	 * @author Younes Saoudi
	 *
	 */
	private class Refresh implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			new CurrentOrders(Employee);
			window.dispose();
			Refresh.repaint();

		}
	}
	
	/**
	 * Reset the filters
	 * @author Younes Saoudi
	 *
	 */
	private class actionClear implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			t2.setText("");
			tTablenm.setText("");
			tPayment.setText("");
			tDate.setText("");
			comboBoxPayment.setSelectedIndex(0);
			comboBoxTableNm.setSelectedIndex(0);
			comboBoxDate.setSelectedIndex(0);
			comboBoxHour.setSelectedIndex(0);
		}
	}
	
	/**
	 * Return to Employee Interface
	 * @author Younes Saoudi
	 *
	 */
	private class Return implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			new EmployeeInterface(Employee);
			window.dispose();
		}
	}
}
