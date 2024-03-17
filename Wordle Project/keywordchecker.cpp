#include "keywordchecker.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QString>
KeywordChecker::KeywordChecker()
{
    // Load and parse the JSON file
    QFile file(":wordlist.json");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Failed to open the file.");
        return;
    }
    QByteArray fileData = file.readAll();
    QJsonDocument document(QJsonDocument::fromJson(fileData));
    QJsonObject rootObj = document.object();

    // Combine both word lists
    QJsonArray wordlist = rootObj["wordlist"].toArray();
    QJsonArray usableWords = rootObj["usableWords"].toArray();

    // Insert all words from "wordlist" into a set
    for (const QJsonValue &value : wordlist) {
        m_word_set.insert(value.toString());
    }

    // Insert all words from "usableWords" into the same set
    for (const QJsonValue &value : usableWords) {
        m_word_set.insert(value.toString());
    }
}

bool KeywordChecker::isKeywordValid(const QString& keyword)
{
    return m_word_set.contains(keyword);

}
