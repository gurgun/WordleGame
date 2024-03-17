#ifndef KEYWORDCHECKER_H
#define KEYWORDCHECKER_H

#include <QSet>



class KeywordChecker {
public:
    KeywordChecker();
    bool isKeywordValid(const QString& keyword);
private:
    QSet<QString> m_word_set;
};

#endif // KEYWORDCHECKER_H
