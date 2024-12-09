import CLIPSJNI.Environment;
import CLIPSJNI.PrimitiveValue;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.BreakIterator;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

class TvShows implements ActionListener {

    JLabel displayLabel;
    JButton nextButton;
    JButton prevButton;
    JPanel choicesPanel;
    ButtonGroup choicesButtons;
    ResourceBundle tvResources;

    Environment clips;
    boolean isExecuting = false;
    Thread executionThread;

    TvShows() {
        try
        {
            tvResources = ResourceBundle.getBundle("resources.TvResources", Locale.getDefault());
        }
        catch (MissingResourceException mre)
        {
            mre.printStackTrace();
            return;
        }

        JFrame jfrm = new JFrame(tvResources.getString("tvShows"));

        jfrm.getContentPane().setLayout(new GridLayout(3,1));

        jfrm.setSize(350,200);

        jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel displayPanel = new JPanel();
        displayLabel = new JLabel();
        displayPanel.add(displayLabel);

        choicesPanel = new JPanel();
        choicesButtons = new ButtonGroup();


        JPanel buttonPanel = new JPanel();

        prevButton = new JButton(tvResources.getString("Restart"));
        prevButton.setActionCommand("Restart");
        buttonPanel.add(prevButton);
        prevButton.addActionListener(this);

        nextButton = new JButton(tvResources.getString("Next"));
        nextButton.setActionCommand("Next");
        buttonPanel.add(nextButton);
        nextButton.addActionListener(this);

        jfrm.getContentPane().add(displayPanel);
        jfrm.getContentPane().add(choicesPanel);
        jfrm.getContentPane().add(buttonPanel);

        clips = new Environment();

        clips.load("tvshows.clp");

        clips.reset();
        runTv();

        jfrm.setVisible(true);
    }

    public void runTv()
    {
        Runnable runThread =
                new Runnable()
                {
                    public void run()
                    {
                        clips.run();

                        SwingUtilities.invokeLater(
                                new Runnable()
                                {
                                    public void run()
                                    {
                                        try
                                        {
                                            nextUIState(); }
                                        catch (Exception e)
                                        { e.printStackTrace(); }
                                    }
                                });
                    }
                };

        isExecuting = true;

        executionThread = new Thread(runThread);

        executionThread.start();
    }

    private void nextUIState() throws Exception
    {
        String evalStr = "(find-all-facts ((?f view)) TRUE)";

        PrimitiveValue fv = clips.eval(evalStr).get(0);


        String theText = tvResources.getString(fv.getFactSlot("question").toString());


        if (fv.getFactSlot("state").toString().equals("final"))
        {
            String rest = tvResources.getString("powinienes");
            theText = rest +" "+ theText;
            nextButton.setActionCommand("Restart");
            nextButton.setText(tvResources.getString("Restart"));
            prevButton.setVisible(false);
        }
        else if (fv.getFactSlot("state").toString().equals("initial"))
        {

            nextButton.setActionCommand("Next");
            nextButton.setText(tvResources.getString("Next"));
            prevButton.setVisible(false);
        }
        else
        {
            //nextButton.setActionCommand("Next");
            //nextButton.setText(tvResources.getString("Next"));
            prevButton.setVisible(true);
        }

        choicesPanel.removeAll();
        choicesButtons = new ButtonGroup();

        PrimitiveValue pv = fv.getFactSlot("valid-answers");

        //String selected = fv.getFactSlot("response").toString();

        for (int i = 0; i < pv.size(); i++)
        {
            PrimitiveValue bv = pv.get(i);
            JRadioButton rButton;

            if (i==0)
            { rButton = new JRadioButton(tvResources.getString(bv.toString()),true); }
            else
            { rButton = new JRadioButton(tvResources.getString(bv.toString()),false); }

            rButton.setActionCommand(bv.toString());
            choicesPanel.add(rButton);
            choicesButtons.add(rButton);
        }

        choicesPanel.repaint();


        wrapLabelText(displayLabel,theText);

        executionThread = null;

        isExecuting = false;
    }

    public void actionPerformed(
            ActionEvent ae)
    {
        try
        { onActionPerformed(ae); }
        catch (Exception e)
        { e.printStackTrace(); }
    }

    public void onActionPerformed(
            ActionEvent ae) throws Exception
    {
        if (isExecuting) return;

        String evalStr = "(find-all-facts ((?f view)) TRUE)";
        PrimitiveValue view = clips.eval(evalStr).get(0);
        String answer = view.getFactSlot("answer").toString();

        if (ae.getActionCommand().equals("Next"))
        {
            if (choicesButtons.getButtonCount() == 0)
            { clips.assertString("( " + answer + ")"); }
            else
            {
                clips.assertString("( " + answer + " "+
                        choicesButtons.getSelection().getActionCommand() +
                        ")");
            }
            //clips.assertString("(move)");
            runTv();
        }
        else if (ae.getActionCommand().equals("Restart"))
        {
            //clips.eval("(find-all-facts ((?f currentId)) TRUE ) ");

            clips.reset();
            runTv();
        }
    }

    private void wrapLabelText(
            JLabel label,
            String text)
    {
        FontMetrics fm = label.getFontMetrics(label.getFont());
        Container container = label.getParent();
        int containerWidth = container.getWidth();
        int textWidth = SwingUtilities.computeStringWidth(fm,text);
        int desiredWidth;

        if (textWidth <= containerWidth)
        { desiredWidth = containerWidth; }
        else
        {
            int lines = (int) ((textWidth + containerWidth) / containerWidth);

            desiredWidth = (int) (textWidth / lines);
        }

        BreakIterator boundary = BreakIterator.getWordInstance();
        boundary.setText(text);

        StringBuffer trial = new StringBuffer();
        StringBuffer real = new StringBuffer("<html><center>");

        int start = boundary.first();
        for (int end = boundary.next(); end != BreakIterator.DONE;
             start = end, end = boundary.next())
        {
            String word = text.substring(start,end);
            trial.append(word);
            int trialWidth = SwingUtilities.computeStringWidth(fm,trial.toString());
            if (trialWidth > containerWidth)
            {
                trial = new StringBuffer(word);
                real.append("<br>");
                real.append(word);
            }
            else if (trialWidth > desiredWidth)
            {
                trial = new StringBuffer("");
                real.append(word);
                real.append("<br>");
            }
            else
            { real.append(word); }
        }

        real.append("</html>");

        label.setText(real.toString());
    }

    public static void main(String args[])
    {
        // Create the frame on the event dispatching thread.
        SwingUtilities.invokeLater(
                new Runnable()
                {
                    public void run() { new TvShows(); }
                });
    }
}


