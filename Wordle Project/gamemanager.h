#ifndef GRIDMANAGER_H
#define GRIDMANAGER_H

#include "keywordchecker.h"
#include <QObject>
#include <QQmlApplicationEngine>
#include <QColor>

class GameManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> cellTexts READ cellTexts WRITE setCellTexts NOTIFY cellTextsChanged)
    Q_PROPERTY(QList<QColor> cellColors READ cellColors WRITE setCellColors NOTIFY cellColorsChanged)
    Q_PROPERTY(QList<QList<QColor>> keyColors READ keyColors WRITE setKeyColors NOTIFY keyColorsChanged)

public:
    explicit GameManager(QObject *parent = nullptr, const QList<QString>& word_candidates = {});


    Q_INVOKABLE void pushKeyIfSuitable(const QString& text);
    Q_INVOKABLE void deleteKeyIfSuitable( );
    Q_INVOKABLE void checkWord();
    Q_INVOKABLE void resetGame();


    void updateCellColor(int index, const QColor& color);
    void updateCellText(int index, const QString &text);
    void updateKeyColor(QPair<int,int> index, QColor& color);

    QList<QColor> cellColors() const;
    QList<QString> cellTexts() const;
    bool hasWon() const;
    QList<QList<QColor>> keyColors() const;


signals:
    void hasWonChanged(const bool hasWon);
    void onWon();
    void onNonSuitableWord();
    void onFailed(const QString& correctWord);
    void keyColorsChanged();
    void cellTextsChanged();
    void cellColorsChanged();


public slots:
    void setKeyColors(QList<QList<QColor>> keyColors);
    void setCellTexts(QList<QString> texts);
    void setCellColors(QList<QColor> cellColors);

private:
    KeywordChecker m_keyword_checker {};
    QList<QString> m_cellTexts {};
    QString m_target_word{};
    int m_left_pointer {};
    int m_right_pointer {};
    int m_word_size {5};

    QPair<int, int> getIndexOfKey(const QString& key);
    QList<QString> m_candidate_words;
    QList<QColor> m_cellColors;
    bool m_hasWon;
    QList<QList<QColor>> m_keyColors;
    void initialize();
    void chooseTargetWord();

};

#endif // GRIDMANAGER_H
