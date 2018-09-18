/**************************************************************************
This file is part of JahshakaVR, VR Authoring Toolkit
http://www.jahshaka.com
Copyright (c) 2016  GPLv3 Jahshaka LLC <coders@jahshaka.com>

This is free software: you may copy, redistribute
and/or modify it under the terms of the GPLv3 License

For more information see the LICENSE file
*************************************************************************/

#ifndef DONATEDIALOG_HPP
#define DONATEDIALOG_HPP

#include <QDialog>

namespace Ui {
    class DonateDialog;
}

class SettingsManager;

class DonateDialog : public QDialog
{
    Q_OBJECT

public:
    DonateDialog(QDialog *parent = Q_NULLPTR);
    ~DonateDialog();

public slots:
    void saveAndClose();

private:
    Ui::DonateDialog *ui;
    SettingsManager *settingsManager;
};

#endif // DONATEDIALOG_HPP