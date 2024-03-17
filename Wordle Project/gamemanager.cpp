#include "gamemanager.h"

#include <QDebug>
#include <QString>
#include <QRandomGenerator>
#include <QStringList>

void GameManager::pushKeyIfSuitable(const QString& text)
{
    if (text == "Enter" || text == "Del") return;

    if (m_right_pointer-m_left_pointer > 0 && m_right_pointer % m_word_size == 0) return;

    m_right_pointer++;
    // qDebug() << "right ptr: " << m_right_pointer << "\n";

    m_cellTexts.push_back(text);
    emit cellTextsChanged();
}

void GameManager::deleteKeyIfSuitable()
{
    if (m_right_pointer - m_left_pointer <= 0) return;
    m_right_pointer--;
    m_cellTexts.pop_back();
    emit cellTextsChanged();
}


GameManager::GameManager(QObject *parent, const QList<QString>& word_candidates)
    : QObject{parent},  m_candidate_words{word_candidates}
{
    initialize();
}

QList<QString> GameManager::cellTexts() const
{
    return m_cellTexts;
}

void GameManager::setCellTexts(QList<QString> texts)
{
    if (texts != m_cellTexts) {
        m_cellTexts = texts;
        emit cellTextsChanged();
    }
}

void GameManager::setCellColors(QList<QColor> cellColors)
{
    if (cellColors != m_cellColors) {
        m_cellColors = cellColors;
        emit cellTextsChanged();
    }
}

QPair<int, int> GameManager::getIndexOfKey(const QString &key)
{
    int row;
    int col;
    QString qwerty_row { "qwertyuiop" };
    QString asd_row { "asdfghjkl" };
    QString zxc_row { "zxcvbnm" };

    if (qwerty_row.contains(key)){
        row = 0;
        col = qwerty_row.indexOf(key);
    }
    else if (asd_row.contains(key)){
        row = 1;
        col = asd_row.indexOf(key);
    }
    else if (zxc_row.contains(key)){
        row = 2;
        col = zxc_row.indexOf(key);
    }
    else {
        row = -1;
        col = -1;
        // qDebug() << "invalid key\n";
    }
    return QPair<int, int> {row, col};
}

void GameManager::initialize()
{
    for (int i = 0; i < 30; i++){
        m_cellColors.push_back("#121213");
    }

    for (int i = 0; i < 3; i++){
        QList<QColor> l {};
        m_keyColors.push_back(l);
    }
    for (int i = 0; i < 10; i++){ //initialize the colors
        m_keyColors[0].push_back("#818384");
    }

    for (int i = 0; i < 9; i++){ //
        m_keyColors[1].push_back("#818384");
    }

    for (int i = 0; i < 7; i++){ //
        m_keyColors[2].push_back("#818384");
    }

    emit keyColorsChanged();
    emit cellTextsChanged();
    emit cellColorsChanged();

    chooseTargetWord();
}

void GameManager::chooseTargetWord()
{
    int randomIndex = QRandomGenerator::global()->bounded(m_candidate_words.size());

    // Use the random index to select a word from the list
    m_target_word = m_candidate_words.at(randomIndex);

}

QList<QColor> GameManager::cellColors() const
{
    return m_cellColors;
}

bool GameManager::hasWon() const
{
    return m_hasWon;
}

QList<QList<QColor> > GameManager::keyColors() const
{
    return m_keyColors;

}
void GameManager::updateCellText(int index, const QString &text)
{
    if (index >= 0 && index < m_cellTexts.size()) {
        m_cellTexts[index] = text;
        emit cellTextsChanged();
    }
}

void GameManager::updateKeyColor(QPair<int, int> index, QColor &color)
{
    m_keyColors[index.first][index.second] = color;
    emit keyColorsChanged();
}

void GameManager::setKeyColors(QList<QList<QColor> > keyColors)
{
    if (m_keyColors == keyColors)
        return;

    m_keyColors = keyColors;
    emit keyColorsChanged();
}

void GameManager::updateCellColor(int index, const QColor& color)
{
    m_cellColors[index] = color;
    emit cellColorsChanged();

}

void GameManager::checkWord()
{
    if (m_right_pointer-m_left_pointer <= 0) return;
    if (m_right_pointer % m_word_size != 0) return;
    QColor wordle_green {"#008000"};
    QColor wordle_yellow {"#b19f46"};
    QColor wordle_gray {"#403c3c"};
    QColor key_gray {"#3a3a3c"};
    bool is_correct { true };
    QSet<QChar> letter_set {};
    QString current_word;
    int init_left_pointer = m_left_pointer;
    for (; m_left_pointer < m_right_pointer; m_left_pointer++){
        current_word += m_cellTexts[m_left_pointer].toLower();
    }
    m_left_pointer = init_left_pointer;
    if (!m_keyword_checker.isKeywordValid(current_word)){
        // qDebug() << "keyword not valid" << "\n";
        emit onNonSuitableWord();
        return;
    }


    for (QChar& el : m_target_word){
        letter_set.insert(el);
    }
    for (; m_left_pointer < m_right_pointer; m_left_pointer++){
        int word_index = m_left_pointer % m_word_size;
        const QChar target_letter = m_target_word[word_index];
        const QChar grid_letter = m_cellTexts[m_left_pointer].toLower()[0];
        const QPair<int,int> key_index = getIndexOfKey(grid_letter);

        if (target_letter == grid_letter){
            updateCellColor(m_left_pointer, wordle_green);
            updateKeyColor(key_index, wordle_green);
        }
        else if(letter_set.contains(grid_letter)){
            updateCellColor(m_left_pointer, wordle_yellow);
            updateKeyColor(key_index, wordle_yellow);
            is_correct = false;
        }
        else{
            updateCellColor(m_left_pointer, wordle_gray);
            updateKeyColor(key_index, key_gray);
            is_correct = false;
        }
    }
    if (m_right_pointer >= 30 && !is_correct){
        //qDebug() << "failed\n";
        emit onFailed(m_target_word);
    }
    m_left_pointer = m_right_pointer;
    if(is_correct){
      emit onWon();
    }
}

void GameManager::resetGame()
{
    m_left_pointer = 0;
    m_right_pointer = 0;
    m_cellTexts.clear();
    m_keyColors.clear();
    m_cellColors.clear();
    initialize();
}
