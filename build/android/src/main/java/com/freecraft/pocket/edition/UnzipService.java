package com.freecraft.pocket.edition;

import android.app.IntentService;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.freecraft.pocket.edition.R;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

public class UnzipService extends IntentService {
    public static final String ACTION_UPDATE = "com.freecraft.pocket.edition.UPDATE";
    public static final String EXTRA_KEY_IN_FILE = "file";
    public static final String EXTRA_KEY_IN_LOCATION = "location";
    public static final String ACTION_PROGRESS = "progress";
    public final String TAG = UnzipService.class.getSimpleName();
    private NotificationManager mNotifyManager;
    private int id = 1;

    public UnzipService() {
        super("com.freecraft.pocket.edition.UnzipService");
    }

    private void isDir(String dir, String unzipLocation) {
        File f = new File(unzipLocation + dir);

        if (!f.isDirectory()) {
            f.mkdirs();
        }
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        mNotifyManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        Notification.Builder mBuilder = new Notification.Builder(this);
        mBuilder.setContentTitle(getString(R.string.notification_title))
                .setContentText(getString(R.string.notification_description)).setSmallIcon(R.drawable.update);
        String[] file = intent.getStringArrayExtra(EXTRA_KEY_IN_FILE);
        String location = intent.getStringExtra(EXTRA_KEY_IN_LOCATION);

        mNotifyManager.notify(id, mBuilder.build());
        int per = 0;
        int size = getSummarySize(file);
        for (String f : file) {
            try {
                try {
                    FileInputStream fin = new FileInputStream(f);
                    ZipInputStream zin = new ZipInputStream(fin);
                    ZipEntry ze;
                    while ((ze = zin.getNextEntry()) != null) {
                        if (ze.isDirectory()) {
                            per++;
                            isDir(ze.getName(), location);
                        } else {
                            per++;
                            int progress = 100 * per / size;
                            // send update
                            publishProgress(progress);
                            FileOutputStream f_out = new FileOutputStream(location + ze.getName());
                            byte[] buffer = new byte[8192];
                            int len;
                            while ((len = zin.read(buffer)) != -1) {
                                f_out.write(buffer, 0, len);
                            }
                            f_out.close();
                            zin.closeEntry();
                            f_out.close();
                        }
                    }
                    zin.close();
                } catch (FileNotFoundException e) {
                    Log.e(TAG, e.getMessage());
                }
            } catch (IOException e) {
                Log.e(TAG, e.getLocalizedMessage());
            }
        }
    }

    private void publishProgress(int progress) {
        Intent intentUpdate = new Intent(ACTION_UPDATE);
        intentUpdate.putExtra(ACTION_PROGRESS, progress);
        sendBroadcast(intentUpdate);
    }

    private int getSummarySize(String[] zips) {
        int size = 0;
        for (String z : zips) {
            try {
                ZipFile zipSize = new ZipFile(z);
                size += zipSize.size();
            } catch (IOException e) {
                Log.e(TAG, e.getLocalizedMessage());
            }
        }
        return size;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mNotifyManager.cancel(id);
        publishProgress(-1);
    }
}
