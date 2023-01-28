# Table definition

```sql
CREATE TABLE countries (
  id INT NOT NULL AUTO_INCREMENT,
  iso VARCHAR(2) NOT NULL,
  iso3 VARCHAR(3) NOT NULL,
  iso_numeric INT NOT NULL,
  country_name VARCHAR(64) NOT NULL,
  capital VARCHAR(64) NOT NULL,
  continent_code VARCHAR(2) NOT NULL,
  currency_code VARCHAR(3) NOT NULL,
  PRIMARY KEY(Id)
);
```

# Data

```
INSERT INTO countries
  (iso, iso3, iso_numeric, country_name, capital, continent_code, currency_code)
VALUES
  ('AU', 'AUS', 36, 'Australia', 'Canberra', 'OC', 'AUD'),
  ('DE', 'DEU', 276, 'Germany', 'Berlin', 'EU', 'EUR'),
  ('US', 'USA', 840, 'United States', 'Washington', 'NA', 'USD')
;

```

# Jenkinsfile version 1

```groovy
pipeline {
  agent { label 'linux' }
  stages {
    stage('query') {
      steps {
        sh(script:'''
          mysql -N -u jenkins -ppassword1 -h 192.168.32.11 my_app -e "select json_object('iso',iso,'country_name',country_name,'currency_code',currency_code) from countries where iso='US'"
        ''')
      }
    }
  }
}
```

# Jenkinsfile version 2
```groovy
pipeline {
  agent { label 'linux'}
  environment {
    MARIADB_CREDS=credentials('mariadb-credentials')
  }
  stages {
    stage('query') {
      steps {
        sh(script:'''
          mysql -N -u $MARIADB_CREDS_USR -p$MARIADB_CREDS_PSW -h 192.168.32.11 my_app -e "select json_object('iso',iso,'country_name',country_name,'currency_code',currency_code) from countries where iso='US'"
        ''')
      }
    }
  }
}
```

# Jenkinsfile version 3
```groovy
pipeline {
  agent { label 'linux'}
  environment {
    MARIADB_CREDS=credentials('mariadb-credentials')
  }
  stages {
    stage('query') {
      steps {
        sh(script:'''
          echo -e "[client]\nuser=$MARIADB_CREDS_USR\npassword=$MARIADB_CREDS_PSW\nhost=192.168.32.11\ndatabase=my_app" | mysql --defaults-file=/dev/stdin -N -e "select json_object('iso',iso,'country_name',country_name,'currency_code',currency_code) from countries where iso='US'"
        ''')
      }
    }
  }
}
```

# Jenkinsfile version 4
```groovy
pipeline {
  agent { label 'linux'}
  environment {
    MARIADB_CREDS=credentials('mariadb-credentials')
  }
  parameters {
    choice(name: 'ISO_CODE', choices: ['US', 'AU', 'DE'], description: 'Select ISO code')
  }
  stages {
    stage('query') {
      steps {
        sh(script:'''
          echo -e "[client]\nuser=$MARIADB_CREDS_USR\npassword=$MARIADB_CREDS_PSW\nhost=192.168.32.11\ndatabase=my_app" | mysql --defaults-file=/dev/stdin -N -e "select json_object('iso',iso,'country_name',country_name,'currency_code',currency_code) from countries where iso=\\\"$ISO_CODE\\\""
        ''')
      }
    }
  }
}
```

# Jenkinsfile version 5
```groovy
pipeline {
  agent { label 'linux'}
  environment {
    MARIADB_CREDS=credentials('mariadb-credentials')
  }
  parameters {
    choice(name: 'ISO_CODE', choices: ['US', 'AU', 'DE'], description: 'Select ISO code')
  }
  stages {
    stage('query') {
      steps {
        sh(script:'''
          echo -e "[client]\nuser=$MARIADB_CREDS_USR\npassword=$MARIADB_CREDS_PSW\nhost=192.168.32.11\ndatabase=my_app" | mysql --defaults-file=/dev/stdin -N -e "select json_object('iso',iso,'country_name',country_name,'currency_code',currency_code) from countries where iso=\\\"$ISO_CODE\\\"" | jq -r ".country_name"
        ''')
      }
    }
  }
}
```
